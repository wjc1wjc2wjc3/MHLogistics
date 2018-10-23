//
//  LoginInfoUtils.h
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LoginState) {
    online = 1,     //登录状态
    offline = 2,    //不在线
};

@interface LoginInfoUtils : NSObject

+ (void)saveLoginState:(LoginState)state loginName:(NSString *)name;
+ (NSInteger)getLoginState:(NSString *)name;


@end
