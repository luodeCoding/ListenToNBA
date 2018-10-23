//
//  UIButton+Util.h
//  FoodPlan2
//
//  Created by YU on 16/10/9.
//  Copyright © 2016年 YU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Util)

/**
 将Button的背景色（0x1d85e6 和0xfcfcfc）

 @param flag YES 将背景色由0xfcfcfc变为0x1d85e6
 */
- (void)changeBGColorTo1D85E6:(BOOL)flag;
+ (void)customSureButton:(UIButton *)bt;
+ (void)customCancelButton:(UIButton *)bt;
+ (void)customDownButton:(UIButton *)bt;
+ (void)customChooseButton:(UIButton *)bt;
@end
