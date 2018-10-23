//
//  CRCUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 10/23/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "CRCUtils.h"
#import "NSString+Hex.h"

@implementation CRCUtils

+ (NSString *)caculateCRC:(NSString *)src {
    
    if (!src || [@"" isEqualToString:src]) {
        return src;
    }
    
    NSString *srcCRC = @"";
    NSInteger srcCRCInt = 0;
    NSInteger length = src.length;
    if (length < 2) {
        return src;
    }
    
    NSInteger div = length / 2;
    NSInteger mod = length % 2;
    div = mod == 0 ? div : (div + 1);
    for (NSInteger i = 0; i < div; i++) {
        NSString *sub = [src substringWithRange:NSMakeRange(i * 2, 2)];
        if (sub) {
            NSInteger subHex = [sub strToHex];
            subHex = subHex & 0xFF;
            srcCRCInt += subHex;
        }
    }
    if (srcCRCInt == 0) {
        srcCRC = @"00000000";
    }
    else
    {
        srcCRCInt = srcCRCInt & 0xFFFFFFFF;
        NSString *crcHexString = [NSString stringWithFormat:@"%08lx", (unsigned long)srcCRCInt];
        srcCRC = crcHexString;
    }
    
    return srcCRC;
}


+ (NSString *)createCRC:(NSString *)format, ... {
    
    NSString *crcResult = @"";
    crcResult = [self bitSum:crcResult add:format];
    NSString *arg;
    va_list argList;
    if (format) {
        va_start(argList, format);
        while ((arg = va_arg(argList, NSString *))) {
            crcResult = [self bitSum:crcResult add:arg];
            
        }
        va_end(argList);
    }
    
    return crcResult;
}

+ (NSString *)bitSum:(NSString *)src add:(NSString *)addtion {
    
    NSInteger srcLength = src.length;
    NSInteger addLength = addtion.length;
    
    if (srcLength == 0) {
        return addtion;
    }
    
    if (addLength == 0) {
        return src;
    }
    
    NSInteger maxLength = srcLength > addLength ? srcLength : addLength;
    NSInteger minLength = addLength < srcLength ? addLength : srcLength;
    NSMutableArray *sumArray = [NSMutableArray arrayWithCapacity:maxLength];
    NSString *highBit = @"";
    if (srcLength > addLength) {
        highBit = [src substringToIndex:(srcLength - addLength)];
        src = [src substringFromIndex:(srcLength - addLength)];
    }
    else
    {
        highBit = [addtion substringToIndex:(addLength - srcLength)];
        addtion = [addtion substringFromIndex:(addLength - srcLength)];
    }
    
    for (NSInteger i = 0; i < minLength; i++) {

        NSString *srcCh = [src substringWithRange:NSMakeRange(i, 1)];
        NSString *addtionCh = [addtion substringWithRange:NSMakeRange(i, 1)];
        NSInteger sum = [srcCh strToHex] + [addtionCh strToHex];
        [sumArray insertObject:[self strToHex:sum] atIndex:i];
        
    }
    
    NSString *sum = @"";
    for (NSString *bitSum in sumArray) {
        sum = [@"" stringByAppendingFormat:@"%@%@", sum,bitSum];
    }
    
    sum = [@"" stringByAppendingFormat:@"%@%@", highBit, sum];
    return sum;
}

+ (NSString *)strToHex:(NSInteger)num {
    if (num >= 16) {
        return @"F";
    }
    
    if (num < 10) {
        return [@"" stringByAppendingFormat:@"%ld", num];
    }
    
    NSInteger reminder = 16 - num;
    NSString *hex = @"F";
    switch (reminder) {
        case 1:
            hex = @"F";
            break;
        case 2:
            hex = @"E";
            break;
        case 3:
            hex = @"D";
            break;
        case 4:
            hex = @"C";
            break;
        case 5:
            hex = @"B";
            break;
        case 6:
            hex = @"A";
            break;
            
        default:
            break;
    }
    return hex;
}

@end
