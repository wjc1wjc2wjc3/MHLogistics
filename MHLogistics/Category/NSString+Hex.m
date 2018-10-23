//
//  NSString+Hex.m
//  HZBitSmartLock
//
//  Created by Apple on 10/21/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "NSString+Hex.h"

@implementation NSString (Hex)

- (NSString *)numberToStr:(NSUInteger)hexNumber {
    char hexChar[6];
    sprintf(hexChar, "%x", (int)hexNumber);
    
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    
    return hexString;
}

- (NSString *)numberToStrFour:(NSUInteger)hexNumber {
    char hexChar[8];
    sprintf(hexChar, "%x", (int)hexNumber);
    
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    
    return hexString;
}

- (NSString *)numberToStrTwo:(NSUInteger)hexNumber {
    char hexChar[4];
    sprintf(hexChar, "%0lx", hexNumber);
    
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    
    return hexString;
}

- (NSString *)numberToByte:(NSUInteger)hexNumber {
    char hexChar[4];
    sprintf(hexChar, "%02lx", hexNumber);
    
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    
    return hexString;
}

- (NSInteger)strToHex {
    
    const char *hexChar = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    int hexNumber;
    
    sscanf(hexChar, "%x", &hexNumber);
    
    return (NSInteger)hexNumber;
}

- (NSInteger)longStrToHex {
    
    const char *hexChar = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSInteger hexNumber;
    
    sscanf(hexChar, "%lx", &hexNumber);
    
    return (NSInteger)hexNumber;
}

- (NSString *)hexToDecimalStr {
    unsigned long long result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner scanHexLongLong:&result];
    return [NSString stringWithFormat:@"%lld", result];
}

- (NSString *)base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}

@end
