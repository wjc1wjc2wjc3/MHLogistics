//
//  GetAllDDYSjInfoResultData.h
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "BaseRequestResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface SjsData : BaseRequestResult

@property (nonatomic, copy) NSString *UserId;            //司机id
@property (nonatomic, copy) NSString *Name;              //司机名称
@property (nonatomic, copy) NSString *LastLoginTime;     //最近一个登陆时间，时间戳
@property (nonatomic, copy) NSString *LoginState;        //登陆状态，1在线，-1离线

@end

@interface GetAllDDYSjInfoResultData : BaseRequestResult

@property (nonatomic, strong) SjsData *Sjs;              //车辆唯一标识id

@end

NS_ASSUME_NONNULL_END
