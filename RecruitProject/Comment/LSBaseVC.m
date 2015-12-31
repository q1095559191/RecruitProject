//
//  LSBaseVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/21.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSBaseVC.h"

@interface LSBaseVC ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,VPImageCropperDelegate>


@end

@implementation LSBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = color_bg;
    //初始化
    self.dataListArr = [NSMutableArray array];
    self.parDic = [NSMutableDictionary dictionary];
    self.page = 1;
    self.offset = 10;
    //网络请求
    [self httpRequest];
    //添加子视图
    [self creatContentView];
    //设置子视图布局
    [self settingViewLayouts];
//    //添加观察者
//    _fbKVO = [FBKVOController controllerWithObserver:self];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isAppearRefresh) {
        [self httpRequest];
    }
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (_fbKVO) {
        //移除所有观察者
        [_fbKVO unobserveAll];
    }
}


#pragma mark - 上传图片
-(void)postImage:(NSString *)type
{
    //上传图片
    self.imageType = type;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] bk_initWithTitle:nil];
    [actionSheet bk_addButtonWithTitle:@"相册" handler:^{
        UIImagePickerController  *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }];
    [actionSheet bk_addButtonWithTitle:@"拍照" handler:^{
        UIImagePickerController  * imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }];
    [actionSheet bk_setCancelButtonWithTitle:@"取消" handler:nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];

}


#pragma mark -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    [picker dismissViewControllerAnimated:YES completion:^{
        //图片压缩
        UIImage *theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        CGFloat size = 320;
        if ([self.imageType isEqualToString:@"img"]) {
            size = 320;
        }else if ([self.imageType isEqualToString:@"circle_post_img"])
        {
            size = 300;
        }else if ([self.imageType isEqualToString:@"circle_create_logo"])
        {
            size = 300;
        }
        
        else
        {
            size = 320*6;
        }
        
        UIImage *newImage = [self imageWithImageSimple:theImage scaledToSize:CGSizeMake(size, size)];
        // present the cropper view controller
        
        VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:newImage cropFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:2];
        imgCropperVC.delegate = self;
        [self presentViewController:imgCropperVC animated:YES completion:^{
            
        }];
    }];
    
}

#pragma mark - 压缩图片方法
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
    NSData *data;
    NSString *type;
    if (UIImagePNGRepresentation(editedImage)) {
        //返回为png图像。
        data = UIImagePNGRepresentation(editedImage);
        type = @"png";
    }else {
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(editedImage, 0.5);
        type = @"JPEG";
    }
    
    NSString *encodedImageStr =  [MF_Base64Codec base64StringFromData:data];
    encodedImageStr =  [NSString stringWithFormat:@"data:image/%@;base64,%@",type,encodedImageStr];
    //上传图片
    [SVProgressHUD showWithStatus:@"上传中..."];
    //img:头像 organizationcode:组织代码 certificatecode:税务登记证 codeinfo:营业执照
    [LSHttpKit postMethod:@"c=member&a=uploadImg" parameters:@{@"img": encodedImageStr,
                                                                   @"type":self.imageType} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"图片上传成功!"];
        [self postImageSuccess:self.imageType imageUrl:responseObject[@"data"][@"img_url"]];
                                                                       
    }];
    
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)creatTableView:(id)cellID
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = color_bg;
    //tableView数据控制器
    self.tableViewKit = [[LSTableViewKit alloc]intitWithData:self.dataListArr cellID:cellID tableView:self.tableView];
    
  
//    // 马上进入刷新状态
//    [self.tableView.header beginRefreshing];
    
 
}

-(void)addHeaderAndFooterRefresh
{
    [self addHeaderRefresh];
    [self addFooterRefresh];
}

-(void)addFooterRefresh
{
    [self.parDic setObject:[NSString stringWithFormat:@"%ld",(long)self.offset] forKey:@"size"];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
         self.page ++;
        [self.parDic setObject:[NSString stringWithFormat:@"%ld",(long)self.page]   forKey:@"page"];
        [self.parDic setObject:[NSString stringWithFormat:@"%ld",(long)self.offset] forKey:@"size"];
        [self httpRequest];
    }];
   
}

-(void)addHeaderRefresh
{   //添加默认数据
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.page = 1;
        [self.parDic setObject:[NSString stringWithFormat:@"%ld",(long)self.page]   forKey:@"page"];
        [self.parDic setObject:[NSString stringWithFormat:@"%ld",(long)self.offset] forKey:@"size"];
        [self httpRequest];
    }];
}

-(void)endRefresh
{   [SVProgressHUD dismiss];
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}
#pragma markk - 处理空数据
-(void)handleNilData
{

    if (!self.nodataStr) {
        self.nodataStr = @"对不起,暂无数据";
    }
    
    if(self.dataListArr.count == 0)
    {   _noDataLB.hidden = NO;
        self.tableView.hidden = YES;
        if (!_noDataLB) {
            _noDataLB = [UILabel labelWithText:self.nodataStr color:color_black font:14 Alignment:LSLabelAlignment_center];
            [self.view addSubview:_noDataLB];
            _noDataLB.frame = CGRectMake(0, self.view.center.y-50, SCREEN_WIDTH, 30);
        }else
        {
            _noDataLB.text = self.nodataStr;
        }
    }else
    {
        _noDataLB.hidden = YES;
        self.tableView.hidden = NO;
    }


}

-(void)handleNilData:(NSString *)title image:(NSString *)image
{
    if (!title) {
      title = @"对不起,暂无数据";
    }
    
    if(self.dataListArr.count == 0)
    {   _noDataLB.hidden = NO;
        self.tableView.hidden = YES;
        if (!_noDataLB) {
            _noDataLB = [UILabel labelWithText:title color:color_black font:14 Alignment:LSLabelAlignment_center];
            [self.view addSubview:_noDataLB];
            _noDataLB.frame = CGRectMake(0, self.view.center.y-50, SCREEN_WIDTH, 30);
        }else
        {
            _noDataLB.text = title;
        }
        
    }else
    {
        _noDataLB.hidden = YES;
        self.tableView.hidden = NO;
    }


}


-(void)SetHeightForRow:(TableViewHeightForRowBlock)HeightForRowBlock Header:(TableViewHeightForHeaderBlock)HeightForHeaderBlock Footer:(TableViewHeightForFooterBlock)HeightForFooterBlock
{
     _HeightForRowBlock   =  HeightForRowBlock;
     _HeightForHeaderBlock =  HeightForHeaderBlock;
     _HeightForFooterBlock =  HeightForFooterBlock;
}

#pragma mark - tablewDelegate
//cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_HeightForRowBlock)
    {
      return _HeightForRowBlock(tableView,indexPath);
    }
    
    //默认
    return 50;
    
}

//头部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(_HeightForHeaderBlock)
    {
      return  _HeightForHeaderBlock(tableView,section);
    }
     //默认
    return 0.01;
}


//底部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(_HeightForFooterBlock)
    {
      return    _HeightForFooterBlock(tableView,section);
    }
    return 20;
}

//取消分割线
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}


@end
