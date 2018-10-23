
//
//  MBProgressHUD+MBProgressHUD_Util.h
//  NewFood
//
//  Created by 罗德良 on 16/10/19.
//  Copyright © 2016年 YU. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (MBProgressHUD_Util)

+ (void)alertHUDShowIn:(UIView *)v message:(NSString *)message hidenAfter:(NSTimeInterval)delay mode:(MBProgressHUDMode)mode;

+ (void)customHud:(MBProgressHUD *)hud Text:(NSString *)text;
@end
