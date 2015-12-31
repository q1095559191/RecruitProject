//
//  LSPopListVIew.m
//  RecruitProject
//
//  Created by sliu on 15/11/6.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSPopListVIew.h"

@implementation LSPopListVIew

+(instancetype)popListView:(NSArray *)listarr
{
    UITableView *view = [[UITableView alloc] init];
    view.frame = CGRectMake(0, 0, 60, 40*listarr.count);
    LSPopListVIew *popTipView = [[LSPopListVIew alloc] initWithCustomView:view];
    popTipView.listarr = listarr;
    view.delegate   = popTipView;
    view.dataSource = popTipView;
    view.backgroundColor       = color_clear;
    popTipView.backgroundColor = color_listBG;
    popTipView.animation = CMPopTipAnimationSlide;
    popTipView.has3DStyle = NO;
    popTipView.dismissTapAnywhere = YES;
    popTipView.disableTapToDismiss = YES;
    return popTipView;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listarr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        UILabel *label = [UILabel labelWithText:nil color:color_white font:12 Alignment:LSLabelAlignment_center];
        [cell.contentView addSubview:label];
        label.backgroundColor     = color_clear;
        cell.backgroundColor     = color_clear;
        label.edge(0,0,0,0);
        label.tag = 11;
        
    }
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:11];
    label.text = self.listarr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissAnimated:YES];
    self.showpop = NO;
    self.index = indexPath.row;
    if ([self.delegate respondsToSelector:@selector(popTipViewAction:)]) {
        [self.delegate popTipViewAction:self];
    }

}



@end
