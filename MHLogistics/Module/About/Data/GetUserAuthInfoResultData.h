//
//  GetUserAuthInfoResultData.h
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "BaseRequestResult.h"

NS_ASSUME_NONNULL_BEGIN

//认证状态
typedef NS_ENUM(NSInteger, EnumAuthStatus) {
    eFailture = -1, //认证失败
    eWaitingReview = 0,  //待审核
    eReviewing = 1,  //审核中
    eReviewed = 9,  //审核通过
};

//认证照片
typedef NS_ENUM(NSUInteger, EnumAuthPhotos) {
    eIdentify = 1,  //身份证
    eLicesePlate = 2,   //驾驶证
    eDriveLicese = 3,  //行驶证
    ePeopleCarPhoto = 4,  //人车合影
};

@interface AuthPhotos : BaseRequestResult

@property (nonatomic, copy) NSString *type; //EnumAuthPhotos
@property (nonatomic, copy) NSString *isFront; //0（反面），1（正面）
@property (nonatomic, copy) NSString *url ; //
@end


@interface GetUserAuthInfoResultData : BaseRequestResult

@property (nonatomic, copy) NSString *baseInfo; //
@property (nonatomic, copy) NSString *SJUserId; //
@property (nonatomic, copy) NSString *authStatus; //
@property (nonatomic, copy) NSString *hasIdCard; //
@property (nonatomic, copy) NSString *hasDrivingLicense; //
@property (nonatomic, copy) NSString *hasTravelLicense; //
@property (nonatomic, copy) NSString *hasPplCarPhoto; //
@property (nonatomic, copy) NSString *hasPplIdCardPhoto; //
@property (nonatomic, strong) AuthPhotos *authPhotos; //


@end

NS_ASSUME_NONNULL_END
