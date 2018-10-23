//
//  NSData+Add.h
//  HZBitSmartLock
//
//  Created by Apple on 10/19/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Add)

/**
 Returns a uppercase NSString in HEX.
 */
- (nullable NSString *)hexString;

+ (nullable NSData *)hexToBytes:(nullable NSString *)hexString;

+ (nullable NSData *)dataWithHexString:(nullable NSString *)hexStr;
- (NSString *)base64EncodedString;
@end
