//
//  UIImage+LSSetting.m
//  AMY
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 ASYH. All rights reserved.
//

#import "UIImage+LSSetting.h"

@implementation UIImage (LSSetting)
-(UIImage *)imageCompressForWidth:(CGFloat)defineWidth
{
    UIImage *newImage = nil;
    
    CGSize imageSize = self.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = defineWidth;
    
    CGFloat targetHeight = height / (width / targetWidth);
    
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    
    CGFloat scaleFactor = 0.0;
    
    CGFloat scaledWidth = targetWidth;
    
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        
        CGFloat widthFactor = targetWidth / width;
        
        CGFloat heightFactor = targetHeight / height;
        
        
        if(widthFactor > heightFactor){
            
            scaleFactor = widthFactor;
            
        }
        
        else{
            
            scaleFactor = heightFactor;
            
        }
        
        scaledWidth = width * scaleFactor;
        
        scaledHeight = height * scaleFactor;
        
        
        if(widthFactor > heightFactor){
            
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
            
        }else if(widthFactor < heightFactor){
            
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            
        }
        
    }
    
    
    UIGraphicsBeginImageContext(size);
    
    
    CGRect thumbnailRect = CGRectZero;
    
    thumbnailRect.origin = thumbnailPoint;
    
    thumbnailRect.size.width = scaledWidth;
    
    thumbnailRect.size.height = scaledHeight;
    
    
    [self drawInRect:thumbnailRect];
    
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    if(newImage == nil){
        
        
        NSLog(@"scale image fail");
        
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;

}
@end
