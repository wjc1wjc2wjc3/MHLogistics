//
//  LoginViewController.h
//  MHLogistics
//
//  Created by Apple on 2018/10/23.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "HZBitViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LoginType) {
    eDispatch = 0x01,  //调度员登录
    eEmployed,         //单头司机登录
    eHKDriver,         //香港司机登录
    eDriver,           //骑师登录
};
@interface LoginViewController : HZBitViewController

@property (nonatomic, assign) VCType vcType;

@end

NS_ASSUME_NONNULL_END
