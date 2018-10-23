//
//  AESCryptUtils.h
//  HZBitApp
//
//  Created by Apple on 9/6/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import "FMDBManager.h"
#import "AccountUtils.h"
#import <SAMKeychain/SAMKeychain.h>
#import "NSData+AES.h"

@interface AESCryptUtils : NSObject

/* @brief token由三部分组成,SID+MD5(idcardNoMD5+mac+time)+time;
 *        第一部分：用户的sid
 *        第二部分:（身份证号码取MD5值+当前手机的mac值+当前时间）整体取MD5
 *        第三部分:当前时间
 *        注:接口当中需要校验当前的数字签名是否正确，然后再做后续业务处理.
 *
 *
 * @param sid         用户sid
 * @param identity    身份证号
 * @param timeStamp   时间戳
 */
+ (NSString *)createToken:(NSString *)sid identity:(NSString *)identity time:(NSString *)timeStamp;

+ (NSString *)md5_32bit:(NSString *)input;

/**
 *@brief 加密函数
 *@param enString 需要加密的字符串
 *@param timeStamp 获取加密key的时间戳
 */
+ (NSString *)enCryptString:(NSString *)enString time:(NSString *)timeStamp;

/**
 *@brief 加密函数
 *@param enString 需要加密的字符串
 *@param timeStamp 获取加密key的时间戳
 *@param bFixKey 是否是固定秘钥加密
 */
+ (NSString *)enCryptString:(NSString *)enString time:(NSString *)timeStamp fixKey:(BOOL)bFixKey;

/**
 *@brief 加密函数
 *@param account  账号
 *@param enString 需要加密的字符串
 *@param timeStamp 获取加密key的时间戳
 */
+ (NSString *)enCryptString:(NSString *)account encrypt:(NSString *)enString time:(NSString *)timeStamp;

/**
 *@brief 加密函数
 *@param enString 需要加密的字符串
 *@param key aes加密key
 */
+ (NSString *)enCryptString:(NSString *)enString key:(NSString *)key;


/**
 *@brief 加密函数,不对结果进行base64转换，直接返回的NSData十六进制字符串
 *@param enString 需要加密的字符串
 *@param key aes加密key
 */
+ (NSString *)enCryptStringNoBase64:(NSString *)enString key:(NSString *)key;

/**
 *@brief 解密函数,不对结果进行base64转换，直接返回的NSData十六进制字符串
 *@param desString 需要加密的字符串
 *@param key aes加密key
 */
+ (NSString *)desCryptStringNoBase64:(NSString *)desString key:(NSString *)key;

/**
 *@brief 解密函数
 *@param desString 需要解密的字符串
 *@param timeStamp 获取解密key的时间戳
 */
+ (NSString *)desCryptString:(NSString *)desString time:(NSString *)timeStamp;

/**
 *@brief 解密函数
 *@param desString 需要解密的字符串
 *@param timeStamp 获取解密key的时间戳
 *@param bFixKey   是否是固定秘钥解密
 */
+ (NSString *)desCryptString:(NSString *)desString time:(NSString *)timeStamp fixKey:(BOOL)bFixKey;

/**
 *@brief 解密函数
 *@param desString 需要解密的字符串
 *@param key 获取解密key
 */
+ (NSString *)desCryptString:(NSString *)desString key:(NSString *)key;

/**
 * @brief创建加密key
 * @param timeStamp 时间戳
 */
+ (NSString *)createKey:(NSString *)timeStamp;

+ (NSString *)createToken:(NSString *)timeStamp;

/**
 * @brief创建加密key
 * @param account 账号
 * @param timeStamp 时间戳
 */
+ (NSString *)createKey:(NSString *)account time:(NSString *)timeStamp;

@end
