//
//  DateFormatUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 2018/10/10.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "DateFormatUtils.h"

@implementation DateFormatUtils

//20150207-20350207 --> 2015.02.07-2035.02.07
+ (NSString *)identifyFormat:(NSString *)string {
    if (!string || [@"" isEqualToString:string]) {
        return @"";
    }
    
    NSArray<NSString *> *dateArray = [string componentsSeparatedByString:@"-"];
    NSInteger count = dateArray.count;
    if (count != 2) {
        return string;
    }
    
    ELockWeakSelf();
    NSMutableString *identifyDateFormat = [@"" mutableCopy];
    [dateArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *objFormat = [weakSelf dateFormat:obj];
        [identifyDateFormat appendString:objFormat];
        if (idx != count - 1) {
            [identifyDateFormat appendString:@"-"];
        }
    }];
    
    
    return identifyDateFormat;
    
}

+ (NSString *)dateFormat:(NSString *)dateString {
    if (!dateString || [@"" isEqualToString:dateString]) {
        return @"";
    }
    
    if (dateString.length != 8) {
        return dateString;
    }
    
    NSMutableString *format = [@"" mutableCopy];
    NSString *year = [dateString substringToIndex:4];
    [format appendString:year];
    [format appendString:@"."];
    NSString *month = [dateString substringWithRange:NSMakeRange(4, 2)];
    [format appendString:month];
    [format appendString:@"."];
    NSString *day = [dateString substringWithRange:NSMakeRange(6, 2)];
    [format appendString:day];
    
    return format;
}

@end
