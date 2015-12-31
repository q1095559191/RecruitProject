//
//  LSBaseTextView.m
//  RecruitProject
//
//  Created by sliu on 15/10/28.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSBaseTextView.h"

@implementation LSBaseTextView

-(UITextView *)creatTextView
{
    UITextView *text = [[UITextView alloc] init];
    self.placeholderLB = [UILabel labelWithText:@"" color:[UIColor lightGrayColor] font:14 Alignment:LSLabelAlignment_left];
    [text addSubview:self.placeholderLB];
     self.placeholderLB.edgeNearTop(0,10,0,30);
    
   
    self.maxNumLB = [UILabel labelWithText:@"1/200" color:[UIColor lightGrayColor] font:14 Alignment:LSLabelAlignment_right];
    [text addSubview:self.maxNumLB];

   
    self.textView = text;
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:14];
    
    return text;

}
-(void)setTextStr:(NSString *)text
{
    _textView.text = text;
    self.maxNumLB.text = [NSString stringWithFormat:@"%lu/%li",text.length,(long)self.maxNum];
   self.placeholderLB.hidden = YES;
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placeholderLB.hidden = NO;
        
    }else
    {
        self.placeholderLB.hidden = YES;
    }

}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length+text.length <= self.maxNum) {
        if (range.location) {
            
        }
        self.maxNumLB.text = [NSString stringWithFormat:@"%lu/%li",(unsigned long)textView.text.length+text.length,(long)self.maxNum];
        return YES;
    }else
    {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"最多只能输入%li个字",(long)self.maxNum]];
        return NO;
    }

}



-(void)setMaxNum:(NSInteger)maxNum
{
 _maxNum = maxNum;
 self.maxNumLB.text = [NSString stringWithFormat:@"%lu/%li",(unsigned long)_textView.text.length,(long)_maxNum];
}

@end
