//
//  NSString+Hex.h
//  HZBitSmartLock
//
//  Created by Apple on 10/21/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+Add.h"

@interface NSString (Hex)

- (NSString *)numberToStr:(NSUInteger)hexNumber;
- (NSString *)numberToStrFour:(NSUInteger)hexNumber;
- (NSString *)numberToStrTwo:(NSUInteger)hexNumber;
- (NSString *)numberToByte:(NSUInteger)hexNumber;
- (NSInteger)strToHex;
- (NSInteger)longStrToHex;
//十六进制字符串转成十进制字符串
- (NSString *)hexToDecimalStr;

- (NSString *)base64EncodedString;

@end
