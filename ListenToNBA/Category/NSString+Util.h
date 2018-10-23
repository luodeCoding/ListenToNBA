//
//  NSString+Util.h
//  FoodPlan2
//
//  Created by YU on 16/9/22.
//  Copyright © 2016年 YU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)
//MD5
+ (NSString *)lowerMD5String:(NSString *)string;
//当前应用软件版本  比如：1.0.1
+ (NSString * )appVersions;
//当前平台 如:ipone或者Android
+(NSString *)phonePlatform;
//当前手机系统版本 如:9.7
+(NSString *)phoneSystemVersion;
//当前手机型号 如:iPone6s
+ (NSString *)phoneType;
//设备唯一标识符 如:序列号
+ (NSString *)phoneSerialNum;
//获取系统时间
+ (NSString *)getSystemFormatTime:(NSString *)format;
//验证数字
- (BOOL)verfiyNumber;
//验证是否是金钱
- (BOOL)verfiyMoney;
//折扣取整、YES向下取整，NO向上取整
- (NSString *)ZQDeletePoint:(BOOL)de;
//获取document文件路径
+ (NSString *)documentPath;
//见String或者int型转换为金额字符串
+ (NSString *)convertToMoneyWith:(NSString *)orig;
//根据attr获取属性字符串
+ (NSMutableAttributedString *)attrStringFrom:(NSArray<NSDictionary *> *)attrArray attrStr:(NSString *)str atRange:(NSArray<NSValue *> *)rangeArray;

@end
