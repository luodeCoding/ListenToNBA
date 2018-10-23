//
//  MBProgressHUD+MBProgressHUD_Util.m
//  NewFood
//
//  Created by 罗德良 on 16/10/19.
//  Copyright © 2016年 YU. All rights reserved.
//

#import "MBProgressHUD+MBProgressHUD_Util.h"

@implementation MBProgressHUD (MBProgressHUD_Util)

+ (void)alertHUDShowIn:(UIView *)v message:(NSString *)message hidenAfter:(NSTimeInterval)delay mode:(MBProgressHUDMode)mode
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:v animated:YES];
    hud.label.text = message;
//    hud.label.numberOfLines = 3;
    hud.mode = mode;
    BOOL isH = (delay <= 0);
    [hud hideAnimated:!isH afterDelay:delay];
    
}

+ (void)customHud:(MBProgressHUD *)hud Text:(NSString *)text {
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
//    hud.label.numberOfLines = 3;
//    [hud hideAnimated:YES afterDelay:0.5];
    [hud hideAnimated:YES afterDelay:0.5];
}


@end
