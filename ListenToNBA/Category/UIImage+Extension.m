//
//  UIImage+Extension.m
//  GoBangGame
//
//  Created by 罗德良 on 2018/10/9.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (UIImage *)imageByScalingToSize:(CGSize)targetSize{
    UIImage * sourceImage = self;
    UIImage * newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth/width;
        CGFloat heightFactor = targetHeight/height;
        if (widthFactor < heightFactor) {
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
            scaledWidth = width * scaleFactor;
            scaledHeight = height * scaleFactor;
        }
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - targetHeight)*0.5;
        }else if (widthFactor > heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth)*0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (newImage == nil) {
        NSLog(@"could not scale image");
    }
    
    return newImage;
}

//等比率缩放
- (UIImage *)scaleImageToScale:(float)scale
{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scale, self.size.height * scale));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scale, self.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/**
 *  获得 子image
 */
- (UIImage*)getSubImage:(CGRect)rect{
    
    CGFloat h_w = rect.size.height/rect.size.width;//高宽比，高:宽
    
    CGFloat width = self.size.width;//真实宽度
    CGFloat height = width*h_w;//真实高度
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, CGRectMake(0, 0, width, height));
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), subImageRef);
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    
    return smallImage;
    
}



//修改图片透明度
- (UIImage *)changeAlphaOfImageWith:(CGFloat)alpha
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
