//
//  NSDate+Extension.h
//  GoBangGame
//
//  Created by 罗德良 on 2018/10/9.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/** 获取当前的时间 */
+ (NSString *)currentDateString;

+ (NSString *)currentDateDayString;

+ (NSString *)currentDateMonthString;

+ (NSString *)currentDateMonthAndDayString;

+ (NSString *)currentDateHourAndSecondString;
//Date转标准化字符串
+ (NSString *)TransformDateStringWithFormat:(NSString *)formatterStr getDate:(NSDate *)date;
//标准化字符串转Date
+ (NSDate *)TransformDateWithFormat:(NSString *)formatterStr getDateString:(NSString *)dateString;

+ (NSDate *)nextMonthDateWithDate:(NSDate *)date;

+ (NSDate *)previousMonthDateWithDate:(NSDate *)date;

+ (NSString *)getWeekDay;

+ (NSString *)getWeekDayWithDate:(NSDate *)date;

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay format:(NSString *)format;

//前一天
+ (NSDate *)lastDay;
//后一天
+ (NSDate *)nextDay;

+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
//时间戳转Date
+ (NSDate *)TransformDate:(NSString *)timeStampString;
@end
