//
//  NSData+AES.h
//  HZBitApp
//
//  Created by Apple on 9/12/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

UIKIT_EXTERN NSString *const salt;
UIKIT_EXTERN NSString *const iv;
UIKIT_EXTERN NSString *const aescrypt_secret;

@interface NSData (AES)

/**
 * @brief 将字符串进行MD5加密
 * @param input 需要进行MD5加密的字符
 */
+ (NSString *)md5_32bit:(NSString *)input;

/* @brief 为密码加盐
 * @param password 需要加盐的密码
 */
+ (NSData *)AESKeyForPassword:(NSString *)password;

/**
 * @brief 对nsdata 数据进行加解密处理
 * @param operation 需要进行的 加密 或者解密操作
 * @param key 加密用户的密码数据
 * @param iv  加密的偏移量
 */
- (NSData *)AESCryptWithOperation:(CCOperation)operation key:(NSData *)key iv:(NSData *)iv;

@end
