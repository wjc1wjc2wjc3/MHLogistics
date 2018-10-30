//
//  UploadDTAuthInfoModel.h
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "HZBitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UploadDTAuthInfoModel : HZBitModel

@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *Phone;
@property (nonatomic, copy) NSString *PhoneHK;
@property (nonatomic, copy) NSString *PhoneEC;
@property (nonatomic, copy) NSString *IDCard;

@end

NS_ASSUME_NONNULL_END
