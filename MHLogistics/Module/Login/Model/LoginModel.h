//
//  LoginModel.h
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "HZBitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : HZBitModel

@property (nonatomic, copy) NSString *Phone;
@property (nonatomic, copy) NSString *Pwd;
@property (nonatomic, copy) NSString *SmsCode;
@property (nonatomic, copy) NSString *UType;
@property (nonatomic, copy) NSString *Device;

@end

NS_ASSUME_NONNULL_END
