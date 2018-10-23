//
//  AccountUtils.m
//  HZBitApp
//
//  Created by Apple on 9/6/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "AccountUtils.h"
#import <SAMKeychain/SAMKeychain.h>

NSString *const HZBit_Service_Account = @"com.hzbit.app.HZBitApp.account";
NSString *const HZBit_LastLoginAccount = @"lastloginaccount";

NSString *const HZBit_Service_IDFA = @"com.hzbit.app.HZBitApp.IDFA";
NSString *const HZBit_IDFA = @"HZBIT_IDFA";

@implementation AccountUtils

// 刷新账号
+ (NSMutableArray *)refreshAccount:(NSString *)loginName {
    if (!loginName|| [loginName compare:@""] == NSOrderedSame) {
        return nil;
    }
    
    NSArray *array = [SAMKeychain accountsForService:HZBit_Service_Account];
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    for (NSDictionary * tUser in array){
        NSString *tUserAccount = [tUser objectForKey:kSAMKeychainAccountKey];
        
        if (![tUserAccount isEqualToString:loginName]){
            if (![tUserAccount isEqualToString:HZBit_LastLoginAccount]){
                [mArray addObject:tUserAccount];
            }
        }
    }
    return mArray;
}


+ (void)saveAccount:(NSString *)account pwd:(NSString *)pwd {
    
    //save the current password and account
    pwd = [@"" mutableCopy];
    [SAMKeychain setPassword:pwd forService:HZBit_Service_Account account:account];
    
    //save the current account for the last account
    [SAMKeychain setPassword:account forService:HZBit_Service_Account account:HZBit_LastLoginAccount];
}

+ (void)saveAccountWithoutPWD:(NSString *)account {
    NSArray *accountList = [self refreshAccount:@""];
    ELockWeakSelf();
    __block BOOL bFound = NO;
    [accountList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *saveAccount = (NSString *)obj;
        if (saveAccount && [saveAccount compare:account] == NSOrderedSame) {
            NSString *pwd = [weakSelf getAccountPWD:account];
            if (pwd) {
                [weakSelf saveAccount:account pwd:pwd];
            }
            else
            {
                [SAMKeychain setPassword:account forService:HZBit_Service_Account account:HZBit_LastLoginAccount];
            }
            
            *stop = YES;
            bFound = YES;
        }
    }];
    
    if (!bFound) {
        [SAMKeychain setPassword:account forService:HZBit_Service_Account account:HZBit_LastLoginAccount];
    }
}

+(void)deleteAccount:(NSString *)account {
    [SAMKeychain deletePasswordForService:HZBit_Service_Account account:HZBit_LastLoginAccount];
    NSError *error = nil;
    [SAMKeychain deletePasswordForService:HZBit_Service_Account account:HZBit_LastLoginAccount error:&error];
}

+ (NSArray *)getAccountList {
    NSArray *accountArray = [SAMKeychain accountsForService:HZBit_Service_Account];
    if (accountArray != nil) {
        NSString *now_pwd = @"";
        NSString *now_account = [SAMKeychain passwordForService:HZBit_Service_Account account:HZBit_LastLoginAccount];
        for (NSDictionary *tUser in accountArray) {
            NSString *tUserAccount = [tUser objectForKey:kSAMKeychainAccountKey];
            if ([tUserAccount isEqualToString:now_account]) {
                now_pwd = [SAMKeychain passwordForService:HZBit_Service_Account account:now_account];
            }
        }
    }
    
    return accountArray;
}

+ (NSString *)getAccountPWD {
    NSString *now_account = [AccountUtils getAccount];
    return [AccountUtils getAccountPWD:now_account];
}

+ (NSString *)getAccountPWD:(NSString *)now_account {
    NSString *now_pwd = @"";
    NSArray *accountArray = [SAMKeychain accountsForService:HZBit_Service_Account];
    if (accountArray != nil) {
        for (NSDictionary *tUser in accountArray) {
            NSString *tUserAccount = [tUser objectForKey:kSAMKeychainAccountKey];
            if ([tUserAccount isEqualToString:now_account]) {
                now_pwd = [SAMKeychain passwordForService:HZBit_Service_Account account:now_account];
                break;
            }
        }
    }
    
    return now_pwd;
}


+ (NSString *)getAccount {
    return [SAMKeychain passwordForService:HZBit_Service_Account account:HZBit_LastLoginAccount];;
}

+ (void)saveIDFA:(NSString *)idfa {
    [SAMKeychain setPassword:idfa forService:HZBit_Service_IDFA account:HZBit_IDFA];
}

+ (NSString *)getIDFA {
    
    NSString *idfa = [SAMKeychain passwordForService:HZBit_Service_IDFA account:HZBit_IDFA];
    
    return idfa ? idfa : @"";
}

@end
