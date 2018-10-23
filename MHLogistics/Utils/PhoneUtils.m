//
//  PhoneUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 10/31/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "PhoneUtils.h"


//电话号码开始不显示的位置
NSInteger PHONE_CONVERTSTART_LENGTH = 3;
//电话号码最后显示的长度
NSInteger PHONE_CONVERTEND_LENGTH = 4;

@implementation PhoneUtils

/*
 format string special phone number eg. 15914042935 --> 159****2935
 @param text string need convert
 */
+ (NSString *)phoneConvertText:(NSString *)text {
    return [PhoneUtils convertText:text start:PHONE_CONVERTSTART_LENGTH end:PHONE_CONVERTEND_LENGTH];
}


+ (NSString *)convertText:(NSString *)text start:(NSInteger)startPos end:(NSInteger)endPos {
    if (!text && [text compare:@""] == NSOrderedSame) {
        return text;
    }
    
    NSInteger startLocation = startPos;
    if (text.length <= startLocation) {
        return text;
    }
    
    NSMutableString * replaceStr = [NSMutableString stringWithString:text];
    NSInteger replace = text.length - startLocation;
    
    replace = replace > endPos ? (replace - endPos) : replace;
    
    NSString *star = @"";
    for (NSInteger i = 0; i < replace; i++) {
        star = [NSString stringWithFormat:@"%@%@", star, @"*"];
    }
    
    [replaceStr replaceCharactersInRange:NSMakeRange(startLocation, replace) withString:star];
    return replaceStr;
}


@end
