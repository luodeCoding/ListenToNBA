//
//  NSDate+Extension.m
//  GoBangGame
//
//  Created by 罗德良 on 2018/10/9.
//  Copyright © 2018年 Roder. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
#pragma mark - 获取当前的时间
+ (NSString *)currentDateString {
    return [self currentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)currentDateDayString {
    return [self currentDateStringWithFormat:@"yyyy-MM-dd"];
}

+ (NSString *)currentDateMonthString {
    return [self currentDateStringWithFormat:@"yyyy-MM"];
}

+ (NSString *)currentDateMonthAndDayString {
    return [self currentDateStringWithFormat:@"MM-dd"];
}

+ (NSString *)currentDateHourAndSecondString {
    return [self currentDateStringWithFormat:@"HH:mm"];
}

//前一天
+ (NSDate *)lastDay {
    
    return [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]];
}
//后一天
+ (NSDate *)nextDay {
    
    return [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];
}

#pragma mark - 按指定格式获取当前的时间
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr {
    // 获取系统当前时间
    NSDate *currentDate = [NSDate date];
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = formatterStr;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    // 输出currentDateStr
    return currentDateStr;
}

#pragma mark - 根据Date转换成string
+ (NSString *)TransformDateStringWithFormat:(NSString *)formatterStr getDate:(NSDate *)date {
    
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = formatterStr;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:date];
    // 输出currentDateStr
    return currentDateStr;
}
#pragma mark - 根据dateString转换成Date
+ (NSDate *)TransformDateWithFormat:(NSString *)formatterStr getDateString:(NSString *)dateString {
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:formatterStr];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
    NSDate*date =[dateFormat dateFromString:dateString];
    
    return date;
}

// 获取date的下个月日期
+ (NSDate *)nextMonthDateWithDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:NSCalendarMatchStrictly];
    return nextMonthDate;
}

// 获取date的上个月日期
+ (NSDate *)previousMonthDateWithDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    NSDate *previousMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:NSCalendarMatchStrictly];
    return previousMonthDate;
}

//获取当前周几
+ (NSString *)getWeekDay
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    //    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:data];
    NSDate * date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}
//转换时间为周几
+ (NSString *)getWeekDayWithDate:(NSDate *)date
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

//比较时间大小
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
//        oneDay 大
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
//        anotherDay 大
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}


//计算天数
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * comp = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:NSCalendarWrapComponents];
    NSLog(@" -- >>  comp : %@  << --",comp);
    return comp.day;
}

//时间戳转换date
+ (NSDate *)TransformDate:(NSString *)timeStampString {
    
    NSTimeInterval interval =[timeStampString doubleValue] / 1000.0;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    return date;
}
@end
