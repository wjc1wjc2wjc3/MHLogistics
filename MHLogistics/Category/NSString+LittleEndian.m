//
//  NSString+LittleEndian.m
//  HZBitSmartLock
//
//  Created by Apple on 30/11/2017.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "NSString+LittleEndian.h"
#import "NSString+Hex.h"

@implementation NSString (LittleEndian)

+ (NSMutableArray *)littleEndianArray:(NSString *)src ; {
    if (!src || [src compare:@""] == NSOrderedSame) {
        return nil;
    }
    
    NSUInteger count = src.length / 4;
    NSMutableArray *timeArray = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = count - 1; i >= 0; i--) {
        NSString *sub = [src substringWithRange:NSMakeRange(i * 4, 4)];
        NSString *high = [sub substringFromIndex:2];
        NSString *low = [sub substringToIndex:2];
        [timeArray addObject:high];
        [timeArray addObject:low];
    }
    return timeArray;
}

+ (NSString *)littleEndian:(NSString *)src {
    NSArray *array = [self littleEndianArray:src];
    NSMutableString *value = [@"" mutableCopy];// @"";
    for (NSString *sub in array) {
        [value appendFormat:@"%@", sub];
    }
    
    return value;
}

+ (BOOL)compareVersion:(NSString *)serverVersion local:(NSString *)lockVersion {
    if(!serverVersion || serverVersion.length < 4) return YES;
    if(!lockVersion || [@"" isEqualToString:lockVersion]) return YES;
    if(![lockVersion containsString:@"."]) return YES;
    
    NSString *maxVersion = [serverVersion substringFromIndex:2];
    NSInteger maxVersionInt = [maxVersion strToHex];
    NSString *litteVersion = [serverVersion substringToIndex:2];
    NSInteger litteVersionInt = [litteVersion strToHex];
    
    NSArray<NSString *> *subArray = [lockVersion componentsSeparatedByString:@"."];
    if(subArray.count != 2) return YES;
    
    NSString *highLock = subArray[0];
    NSString *lowLock = subArray[1];
    
    DLog(@"maxVersion %ld, %ld, %ld, %ld",(long)maxVersionInt, (long)highLock.integerValue, (long)litteVersionInt, (long)lowLock.integerValue);
    if (maxVersionInt > highLock.integerValue) return NO;
    if (maxVersionInt < highLock.integerValue) return YES;
    if (litteVersionInt > lowLock.integerValue) return NO;
    
    return YES;
}

@end
