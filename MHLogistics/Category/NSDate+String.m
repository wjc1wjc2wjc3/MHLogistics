//
//  NSDate+String.m
//  HZBitApp
//
//  Created by Apple on 9/1/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "NSDate+String.h"
#import "NSString+LittleEndian.h"

@implementation NSDate (String)

+ (NSDate *)dateCurrentDayEnd:(NSDate *)date {
    if (!date) {
        date = [NSDate date];
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:date];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    NSDate *finalDate = [NSDate dateWithTimeIntervalSince1970:ts];
    return finalDate;
}

+ (NSDate *)convertDateFromString:(NSString*)srcDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:srcDate];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSString *destDateString = [dateFormatter stringFromDate:date];

    return destDateString;
    
}

+ (NSString *)stringFromDateMin:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

+ (NSString *)stringFromDateSecond:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

/* 2038-01-01 00:00:00 - > ndate */
+ (NSDate *)dateFromString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];

    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}


/* 2038-01-01 00:00:00 - > ndate */
+ (NSDate *)dateFromStringWithAutoFormat:(NSString *)dateString
{
    NSString *format = @"";
    NSUInteger length = dateString.length;
    if (length == 19) {                     //2038-01-01 00:00:00 长度
        format = @"yyyy-MM-dd HH:mm:ss";
    }else if (length == 16) {              //2038-01-01 00:00 长度
        format = @"yyyy-MM-dd HH:mm";
    }else if (length == 13) {             //2038-01-01 00 长度
        format = @"yyyy-MM-dd HH";
    }else if (length == 10) {           //2038-01-01 长度
       format = @"yyyy-MM-dd";
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: format];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}

+ (NSDate *)dateFromStringDay:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (dateString.length == @"2018-01-01".length) {
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    }
    else if (dateString.length == @"2018-01-01 00:00".length) {
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    }
    else if (dateString.length == @"2018-01-01 00:00:00".length) {
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    }
    
    dateFormatter.timeZone =  [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];;
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}

/**
 * 将毫秒时间转换位小端输入的时间
 */
+ (NSMutableArray *)littleEndian:(NSInteger)dateTime {
    NSString *timeStr =  [NSString stringWithFormat:@"%02lx",(long)dateTime];
    
    return [NSString littleEndianArray:timeStr];
}

+ (NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [gregorian setFirstWeekday:2];
    
    //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:serverDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return dayComponents.day;
}

@end
