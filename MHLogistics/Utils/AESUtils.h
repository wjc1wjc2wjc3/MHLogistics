//
//  AESUtils.h
//  HZBitSmartLock
//
//  Created by Apple on 14/11/2017.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

UIKIT_EXTERN NSString *const kAESUtilsKey;

@interface AESUtils : NSObject

+ (NSString *)AESEncryptWithNoPadding:(NSString *)plain password:(NSString *)key;
+ (NSString *)AES128Decrypt:(NSString *)decrypt password:(NSString *)key;

+ (NSData *)AESEncryptWithNoPaddingData:(NSData *)plainData password:(NSData *)keyData;
+ (NSData *)AES128DecryptData:(NSData *)decryptData password:(NSData *)keyData;

@end
