//
//  UIImage+Util.h
//  FoodPlan2
//
//  Created by YU on 16/9/26.
//  Copyright © 2016年 YU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageFromBase64String:(NSString *)base64;
@end
