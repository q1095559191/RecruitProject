//
//  YcKeyBoardView.h
//  KeyBoardAndTextView
//
//  Created by zzy on 14-5-28.
//  Copyright (c) 2014年 zzy. All rights reserved.
//
#define kStartLocation 30
#import <UIKit/UIKit.h>

@class YcKeyBoardView;
@protocol YcKeyBoardViewDelegate <NSObject>

-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView;
@end

@interface YcKeyBoardView : UIView
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) NSIndexPath *index;
@property (nonatomic,copy)   NSString *postID;
@property (nonatomic,assign) id<YcKeyBoardViewDelegate> delegate;
@end
