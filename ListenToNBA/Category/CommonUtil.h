//
//  CommonUtil.h
//  GoBangGame
//
//  Created by 罗德良 on 2018/10/9.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject
//验证手机号码
+ (BOOL)validatePhone:(NSString *)phone;
//验证邮箱
+ (BOOL)validateEmail:(NSString *)email;
//检查是否是正确的银行卡号
+ (BOOL)checkCardNo:(NSString*)cardNo;
//检查身份证号
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;

@end
