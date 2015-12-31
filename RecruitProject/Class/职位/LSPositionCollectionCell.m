//
//  LSPositionCollectionCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/22.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPositionCollectionCell.h"

@implementation LSPositionCollectionCell

- (void)awakeFromNib {
    // Initialization code
    
    self.messageBtn = [UIButton buttonWithTitle:@"发私信" titleColor:color_black BackgroundColor:color_white action:nil];
    [self.contentView addSubview:self.messageBtn];

    self.collectionBtn = [UIButton buttonWithTitle:@"收藏" titleColor:color_black BackgroundColor:color_white action:nil];
    [self.contentView addSubview:self.collectionBtn];
    
    self.collectionBtn.edge(0,10,0,-1);
    self.messageBtn.edge(0,-1,0,10);
    
    self.messageBtn.sizeBy(150,-1);
    self.collectionBtn.sizeBy(150,-1);
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    return self;
}

-(void)configCell:(id)data
{
    
    
}

@end
