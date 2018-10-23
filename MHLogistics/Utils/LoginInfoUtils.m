//
//  LoginInfoUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "LoginInfoUtils.h"

@implementation LoginInfoUtils

+ (void)saveLoginState:(LoginState)state loginName:(NSString *)name {
    if (!name || [name isKindOfClass:[NSNull class]]) {
        DLog(@"name is invalid!");
        return;
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:state forKey:name];
    [userDefault synchronize];
}

+ (NSInteger)getLoginState:(NSString *)name {
    if (!name) {
        return offline;
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault objectForKey:name]) {
        return [userDefault integerForKey:name];
    }
    
    return offline;
}

@end
