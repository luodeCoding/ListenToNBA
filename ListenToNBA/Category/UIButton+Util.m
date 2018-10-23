//
//  UIButton+Util.m
//  FoodPlan2
//
//  Created by YU on 16/10/9.
//  Copyright © 2016年 YU. All rights reserved.
//

#import "UIButton+Util.h"

@implementation UIButton (Util)

- (void)changeBGColorTo1D85E6:(BOOL)flag
{
    if (flag) {
        self.backgroundColor = [UIColor colorWithHex:0x1d85e6];
    }else{
        self.backgroundColor = [UIColor colorWithHex:0xfcfcfc];
    }
}


+ (void)customSureButton:(UIButton *)bt
{
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt setTitleColor:hexColor(0Xe7e8eb, 1) forState:UIControlStateHighlighted];
    
    [bt setBackgroundImage:[UIImage imageWithColor:hexColor(0Xec580f, 1)] forState:UIControlStateNormal];
    [bt setBackgroundImage:[UIImage imageWithColor:hexColor(0xeec7b3, 1)] forState:UIControlStateHighlighted];
    bt.layer.cornerRadius = 3;
    bt.layer.masksToBounds = YES;
}

+ (void)customCancelButton:(UIButton *)bt
{
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt setTitleColor:hexColor(0Xe3e2e2, 1) forState:UIControlStateHighlighted];

    [bt setBackgroundImage:[UIImage imageWithColor:hexColor(0X9c9c9c, 1)] forState:UIControlStateNormal];
    [bt setBackgroundImage:[UIImage imageWithColor:hexColor(0xb5b2b2, 1)] forState:UIControlStateHighlighted];
    bt.layer.cornerRadius = 3;
    bt.layer.masksToBounds = YES;
}

+ (void)customDownButton:(UIButton *)bt
{
    [bt setTitleColor:hexColor(0X1CC5C5, 1) forState:UIControlStateNormal];
    [bt setTitleColor:hexColor(0X1CC5C5, 1) forState:UIControlStateHighlighted];
    [bt setBackgroundImage:[UIImage imageWithColor:hexColor(0XE0F7FF, 1)] forState:UIControlStateNormal];
    [bt setBackgroundImage:[UIImage imageWithColor:hexColor(0X8ce5e7, 1)] forState:UIControlStateHighlighted];
    bt.layer.cornerRadius = 3;
    bt.layer.masksToBounds = YES;
}

+ (void)customChooseButton:(UIButton *)bt {

    [bt setTitleColor:hexColor(0X55554f, 1)forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [bt setTitleColor:hexColor(0Xe7e8eb, 1) forState:UIControlStateHighlighted];
    [bt setTitleColor:hexColor(0Xe7e8eb, 1) forState:UIControlStateSelected | UIControlStateHighlighted];
    
    [bt setBackgroundImage:[UIImage imageWithColor:hexColor(0xf7f7f7, 1)] forState:UIControlStateNormal];
    [bt setBackgroundImage:[UIImage imageWithColor:hexColor(0Xec580f, 1)] forState:UIControlStateSelected];
    [bt setBackgroundImage:[UIImage imageWithColor:hexColor(0xeec7b3, 1)] forState:UIControlStateHighlighted];
    [bt setBackgroundImage:[UIImage imageWithColor:hexColor(0xeec7b3, 1)] forState:UIControlStateHighlighted | UIControlStateSelected];
}

@end
