//
//  UploadDDYAuthInfoModel.h
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "HZBitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UploadDDYAuthInfoModel : HZBitModel
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *Phone;
@property (nonatomic, copy) NSString *CompanyName;
@property (nonatomic, copy) NSString *CompanyPhone;
@property (nonatomic, copy) NSString *CompanyAddr;
@property (nonatomic, copy) NSString *IDCard;
@property (nonatomic, copy) NSString *Email;
@end

NS_ASSUME_NONNULL_END
