//
//  UIImage+Extension.h
//  GoBangGame
//
//  Created by 罗德良 on 2018/10/9.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  放大image
 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

/**
 *  等比率缩放图片
 */
- (UIImage *)scaleImageToScale:(float)scale;

/**
 *  获得 子image
 */
- (UIImage*)getSubImage:(CGRect)rect;

/**
 *  修改图片透明度
 */
- (UIImage *)changeAlphaOfImageWith:(CGFloat)alpha;

@end
