//
//  AccountUtils.h
//  HZBitApp
//
//  Created by Apple on 9/6/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SAMKeychain/SAMKeychain.h>
#import <SAMKeychain/SAMKeychainQuery.h>

UIKIT_EXTERN NSString *const HZBit_Service_Account ;
UIKIT_EXTERN NSString *const HZBit_LastLoginAccount ;

@interface AccountUtils : NSObject

/**
 * @brief 刷新账号列表  登录账号自身不包括在内
 * @param loginName 登录账号
 */
+ (NSMutableArray *)refreshAccount:(NSString *)loginName;

/**
 * @brief 保存账号
 * @param account 账号
 * @param pwd     密码
 */
+ (void)saveAccount:(NSString *)account pwd:(NSString *)pwd;

+ (void)saveAccountWithoutPWD:(NSString *)account;

/**
 * brief 获取登录账号列表
 */
+ (NSArray *)getAccountList;

/**
 * brief 获取登录账号的密码
 */
+ (NSString *)getAccountPWD:(NSString *)now_account;

/**
 * brief 获取登录账号的密码
 */
+ (NSString *)getAccountPWD;

/**
 * brief 获取当前登录的账号
 */
+ (NSString *)getAccount;

/**
 *@ brief 删除该账号相关的信息
 *@ param account
 */
+(void)deleteAccount:(NSString *)account;

/*
 * brief 保存idfa
 */
+ (void)saveIDFA:(NSString *)idfa;

/*
 * brief 获取idfa
 */
+ (NSString *)getIDFA;

@end
