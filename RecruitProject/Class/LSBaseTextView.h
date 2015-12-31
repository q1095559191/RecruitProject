//
//  LSBaseTextView.h
//  RecruitProject
//
//  Created by sliu on 15/10/28.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSBaseTextView : NSObject<UITextViewDelegate>

@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *maxNumLB;
@property (nonatomic,strong) UILabel *placeholderLB;
@property (nonatomic,assign) NSInteger maxNum;

-(UITextView*)creatTextView;
-(void)setTextStr:(NSString *)text;


@end
