//
//  NSString+Util.m
//  FoodPlan2
//
//  Created by YU on 16/9/22.
//  Copyright © 2016年 YU. All rights reserved.
//

#import "NSString+Util.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"
#import "sys/sysctl.h"



@implementation NSString (Util)

+ (NSString *)lowerMD5String:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
//必要4个数据

// 当前应用软件版本  比如：1.0.1

+(NSString *)appVersions {

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    return appCurVersion;
}


//当前平台 如:ipone或者Android
+(NSString *)phonePlatform {

    NSString* platform = [[UIDevice currentDevice] model];
    NSLog(@"当前平台: %@",platform );
    return platform;
}


//当前手机系统版本 如:9.7
+(NSString *)phoneSystemVersion {

    NSString * systemVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"当前手机系统版本: %@",systemVersion);
    return systemVersion;
}


//当前手机型号 如:iPone6s
+(NSString *)phoneType {
    
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = (char*)malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
     return [self getPhoneTypeWithPlatform:platform];
}


//设备唯一标识符 如:序列号
+(NSString *)phoneSerialNum {

    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"设备唯一标识符:%@",identifierStr);
    return identifierStr;
}




//..手机型号

+ (NSString *)getPhoneTypeWithPlatform:(NSString *)platform {
    
    
    
    NSString * phoneType;
    
    
    
    if ([platform isEqualToString:@"iPhone1,1"]) {
        
        
        
        phoneType = @"iPhone 2G";
        
    }
    
    if ([platform isEqualToString:@"iPhone1,2"]) {
        
        
        
        phoneType = @"iPhone 3G";
        
    }
    
    
    
    if ([platform isEqualToString:@"iPhone2,1"]) {
        
        
        
        phoneType = @"iPhone 3GS";
        
    }
    
    if ([platform isEqualToString:@"iPhone3,1"]||[platform isEqualToString:@"iPhone3,2"]||[platform isEqualToString:@"iPhone3,3"]) {
        
        
        
        phoneType = @"iPhone 4";
        
    }
    
    if ([platform isEqualToString:@"iPhone4,1"]) {
        
        
        
        phoneType = @"iPhone 4s";
        
    }
    
    if ([platform isEqualToString:@"iPhone5,1"]||[platform isEqualToString:@"iPhone5,2"]) {
        
        
        
        phoneType = @"iPhone 5";
        
    }
    
    if ([platform isEqualToString:@"iPhone5,3"]||[platform isEqualToString:@"iPhone5,4"]) {
        
        
        
        phoneType = @"iPhone 5c";
        
    }
    
    if ([platform isEqualToString:@"iPhone6,1"]||[platform isEqualToString:@"iPhone6,2"]) {
        
        
        
        phoneType = @"iPhone 5s";
        
    }
    
    if ([platform isEqualToString:@"iPhone7,1"]) {
        
        
        
        phoneType = @"iPhone 6 plus";
        
    }
    
    if ([platform isEqualToString:@"iPhone7,2"]) {
        
        
        
        phoneType = @"iPhone 6";
        
    }
    
    if ([platform isEqualToString:@"iPhone8,1"]) {
        
        
        
        phoneType = @"iPhone 6s";
        
    }
    
    if ([platform isEqualToString:@"iPhone8,2"]) {
        
        
        
        phoneType = @"iPhone 6s plus";
        
    }
    
    if ([platform isEqualToString:@"iPhone8,4"]) {
        
        
        
        phoneType = @"iPhone SE";
        
    }
    
    if ([platform isEqualToString:@"iPhone9,1"]) {
        
        
        
        phoneType = @"iPhone 7";
        
    }
    
    if ([platform isEqualToString:@"iPhone9,2"]) {
        
        
        
        phoneType = @"iPhone 7 plus";
        
    }
    
    if ([platform isEqualToString:@"i386"]||[platform isEqualToString:@"x86_64"]) {
        
        
        
        phoneType = @"iPhone Simulator";
        
    }
    
    
    
    return phoneType;
    
}

//获取系统时间
+ (NSString *)getSystemFormatTime:(NSString *)format {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:currentDate];
}

- (BOOL)verfiyNumber {
    //只能输入数字
    if (self.length >= 1) {
        NSString *channelString = @"^[0-9]+$";
        NSPredicate *channel = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",channelString];
        return [channel evaluateWithObject:self];
    }
    return NO;
}

- (BOOL)verfiyMoney {
    if (self.length >= 1 && ![self isEqualToString:@"0"]) {
        
        NSString *channelString = @"^(([1-9]\\d{0,9})|0)(\\.\\d{1,2})?$";
        NSPredicate *channel = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",channelString];
        return [channel evaluateWithObject:self];
    }
    return NO;
}

- (NSString *)ZQDeletePoint:(BOOL)de
{
    if (![self containsString:@"."]) {
        return self;
    }
    if ([self verfiyMoney]) {
        NSArray *temp = [self componentsSeparatedByString:@"."];
        if (!de) {
            return temp[0];
        }else{
            return [NSString stringWithFormat:@"%ld",[temp[0] integerValue] + 1];
        }
    }
    
    return nil;
}

+ (NSString *)documentPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    MyNSLog(@"%@",path);
    return path;
}

+ (NSString *)convertToMoneyWith:(NSString *)orig
{
    NSString *money = nil;
    if ([orig isKindOfClass:[NSString class]]) {
        money = [NSString stringWithFormat:@"%.2f",[orig floatValue]];
    }
    return money;
}

+ (NSMutableAttributedString *)attrStringFrom:(NSArray<NSDictionary *> *)attrArray attrStr:(NSString *)str atRange:(NSArray<NSValue *> *)rangeArray
{
    if (attrArray.count <=0 || rangeArray.count <= 0) {
//        MyNSLog(@"---------attrArray或rangeArray为空");
        return nil;
    }
    if (attrArray.count != rangeArray.count) {
//        MyNSLog(@"---------attrArray或rangeArray数量不相等");
        return nil;
    }
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSInteger count = 0;
    for (NSDictionary *attr in attrArray) {
        NSValue *v = rangeArray[count];
        [attrStr addAttributes:attr range:v.rangeValue];
        count ++;
    }
    return attrStr;
}

@end






