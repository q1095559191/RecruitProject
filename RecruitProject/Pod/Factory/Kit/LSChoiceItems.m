//
//  LSChoiceItems.m
//  LSLayoutDemo
//
//  Created by admin on 15/8/17.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "LSChoiceItems.h"


@implementation LSChoiceItems
-(void)choiceItems:(NSArray *)titles btn:(UIButton *)btn action:(LSChoiceItemsBlock)action
{
    [self choiceItems:titles btn:btn];
    self.actionBlock = action;
    
}

-(void)choiceItems:(NSArray *)titles btn:(UIButton *)btn
{
    self.titles = titles;
    UITableView *listView = [[UITableView alloc] initWithFrame:CGRectMake(btn.frame.origin.x, btn.frame.size.height+btn.frame.origin.y, btn.frame.size.width, 0) style:UITableViewStylePlain];
    listView.delegate   = self;
    listView.dataSource = self;
    listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView = listView;
    [btn addTarget:self action:@selector(listAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:self.titles[self.selectIndex] forState:UIControlStateNormal];
    [btn.superview addSubview:listView];
//    listView.left.right.top =  btn.left.right.top;
//    listView.sizeBy(-1,0);
    
    self.btn = btn;
}

-(void)listAction:(UIButton *)btn
{
    if (self.listView.frame.size.height == 0) {
        [self show];
    }else
    {
        [self hide];
    }
    [btn setTitle:self.titles[self.selectIndex] forState:UIControlStateNormal];
    if (self.actionBlock) {
        self.actionBlock(self.selectIndex);
    }
}


-(void)show
{
[UIView animateWithDuration:0.5 animations:^{
// [self.listView resetConstraint:3 constant:self.titles.count*30];
 self.listView.frame = CGRectMake(self.listView.frame.origin.x, self.listView.frame.origin.y, self.listView.frame.size.width, self.titles.count*30);
}];
    
}


-(void)hide
{
    [UIView animateWithDuration:0.5 animations:^{
 //[self.listView resetConstraint:3 constant:0];
 self.listView.frame = CGRectMake(self.listView.frame.origin.x, self.listView.frame.origin.y, self.listView.frame.size.width, 0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {  
     return self.titles.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
      return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString *cellID = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.numberOfLines = 1;
    }
    cell.detailTextLabel.text = self.titles[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectIndex = indexPath.row;
    [self listAction:self.btn];
    
}


@end
