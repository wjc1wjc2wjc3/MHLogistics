//
//  NSDate+String.h
//  HZBitApp
//
//  Created by Apple on 9/1/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (String)

+ (NSDate *)convertDateFromString:(NSString*)srcDate;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDateMin:(NSDate *)date;
+ (NSString *)stringFromDateSecond:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSDate *)dateFromStringDay:(NSString *)dateString;
+ (NSDate *)dateFromStringWithAutoFormat:(NSString *)dateString;
+ (NSMutableArray *)littleEndian:(NSInteger)date;
+ (NSDate *)dateCurrentDayEnd:(NSDate *)date;
+ (NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate;
@end
