//
//  FMDBManager.h
//  HZBitApp
//
//  Created by Apple on 9/5/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "DBEntity.h"

UIKIT_EXTERN NSString *const kFMDBID;
UIKIT_EXTERN NSString *const kFMDBName;
UIKIT_EXTERN NSString *const kFMDBIdentity;
UIKIT_EXTERN NSString *const kFMDBIssuance;
UIKIT_EXTERN NSString *const kFMDBExpiration;
UIKIT_EXTERN NSString *const kFMDBPhone;
UIKIT_EXTERN NSString *const kFMDBSid;
UIKIT_EXTERN NSString *const kFMDBMid;

@interface FMDBManager : NSObject

+ (FMDBManager*)sharedInstance;

/**
 * @brief 更新数据库中个人单项信息
 * @param userId  需要更新的人的手机号码
 * @param uid    需要更新的uid
 * @param mid    需要更新的mid
 */
+ (void)updateUID:(NSString *)userId uid:(NSString *)uid mid:(NSString *)mid;

/**
 *@brief 初始化注册人表单  (注册页面使用)
 * @param name             姓名
 * @param identity         身份证
 * @param issuance         签发时间
 * @param expiration       有效期限
 * @param phone            手机号码
 * @param sid              用户sid
 * @param mid              用户mid
 */
- (void)insertData:(NSString *)name identity:(NSString *)identity issuance:(NSString *)issuance expiration:(NSString *)expiration phone:(NSString *)phone sid:(NSString *)sid mid:(NSString *)mid;


/**
 * @brief 更新数据库中个人单项信息
 * @param phone  需要更新的人的手机号码
 * @param key    需要更新的字段       可以的更新的字段查看文件顶部
 * @param value  需要更新的关键字的值
 */
- (void)update:(NSString *)phone key:(NSString *)key value:(NSString *)value;

/**
 * @brief 更新数据库中个人单项信息
 * @param phone  需要更新的人的手机号码
 * @param dictionary    需要更新的字段和值
 */
- (void)update:(NSString *)phone dict:(NSDictionary *)dictionary;

/**
 * @brief 更新数据库中个人单项信息
 * @param db  需要更新数据库
 * @param phone  需要更新的人的手机号码
 * @param key    需要更新的字段       可以的更新的字段查看文件顶部
 * @param value  需要更新的关键字的值
 */
- (void)update:(FMDatabase *)db phone:(NSString *)phone key:(NSString *)key value:(NSString *)value;

/**
 * @brief 根据登录账号查询mid值
 * @param phoneNumber 需要查询个人信息的手机号
 */

- (NSString *)queryMid:(NSString *)phoneNumber;

/**
 * @brief 根据登录账号查询相关信息
 * @param phoneNumber 需要查询个人信息的手机号
 */
- (NSDictionary *)queryData:(NSString *)phoneNumber;

/**
 * @brief 根据登录账号查询相关信息
 * @param key 需要查询个人信息的key
 * @param value 需要查询个人信息的value
 */
- (NSMutableDictionary *)queryData:(NSString *)key value:(NSString *)value;

/**
 * @brief 删除指定账号的信息
 * @param account 指定账号
 */
- (void)deleteWidthAccount:(NSString *)account;

/**
 *   @brief 清楚所有的信息
 */
- (void)clearAll;

@end
