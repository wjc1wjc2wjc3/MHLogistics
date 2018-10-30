//
//  RegisterDeviceData.h
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseData.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterDeviceData : BaseData

@property (nonatomic, copy) NSString *MEID;
@property (nonatomic, copy) NSString *SN;
@property (nonatomic, copy) NSString *IMEI;
@property (nonatomic, copy) NSString *IMEI2;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *osVersion;
@property (nonatomic, copy) NSString *otaVersion;
@property (nonatomic, copy) NSString *pp;

@end

NS_ASSUME_NONNULL_END
