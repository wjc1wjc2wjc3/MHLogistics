//
//  MacUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 06/01/2018.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "MacUtils.h"
#import "NSString+Hex.h"

NSString *const kLockMacPrefix = @"485a4254";

@implementation MacUtils

+ (NSString *)getMac:(NSString *)scanData {
    NSInteger kLockMacPrefixLen = kLockMacPrefix.length;
    if (!scanData || scanData.length < (kLockMacPrefixLen + 6 * 2)) {
        return scanData;
    }
    
    NSMutableString *macM = [@"" mutableCopy];
    NSString *scanDataSub = [scanData substringFromIndex:kLockMacPrefix.length];
    scanDataSub = [scanDataSub substringToIndex:6 * 2];
    [macM appendString:scanDataSub];
    
    return macM;
}

+ (NSString *)createMacAddress:(NSString *)mac {
    if (!mac || [@"" isEqualToString:mac]) {
        DLog(@"mac is invalid!");
        return mac;
    }
    NSMutableString *macAddress = [NSMutableString stringWithFormat:@"%@%@", kLockMacPrefix, mac];
    NSInteger div = macAddress.length / 4;
    NSInteger mod = macAddress.length % 4;
    if (mod != 0) {
        return macAddress;
    }
    
    NSInteger crcHex = 0;
    for (NSInteger i = 0 ; i < div; i++) {
        NSString *sub = [macAddress substringWithRange:NSMakeRange(i * 4, 4)];
        NSInteger subHex = [sub strToHex];
        crcHex += subHex;
    }
    
    NSString *crcStr = [[NSString alloc] numberToStr:crcHex];
    NSMutableString *crc4Str = [@"" mutableCopy];
    if (crcStr.length < 4) {
        NSInteger length = 4 - crcStr.length;
        for (NSInteger i = 0; i < length; i++) {
            [crc4Str appendString:@"0"];
        }
        [crc4Str appendString:crcStr];
    }
    else
    {
        NSString *crcSuffix = [crcStr substringFromIndex:(crcStr.length - 4)];
        [crc4Str appendString:crcSuffix];
    }

    [macAddress appendString:crc4Str];
    return macAddress;
}

@end
