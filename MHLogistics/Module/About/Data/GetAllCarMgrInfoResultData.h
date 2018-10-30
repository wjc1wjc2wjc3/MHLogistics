//
//  GetAllCarMgrInfoResultData.h
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "BaseRequestResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetAllCarMgrInfoResultData : BaseRequestResult

@property (nonatomic, copy) NSString *Gid;              //车辆唯一标识id
@property (nonatomic, copy) NSString *CarType;          //车辆类型，1自备货柜，2吨位车
@property (nonatomic, copy) NSString *HkNO;             //香港车牌号
@property (nonatomic, copy) NSString *DlNO;             //大陆车牌号
@property (nonatomic, copy) NSString *CIQID;            //海关备案号
@property (nonatomic, copy) NSString *ICNO;             //IC卡号
@property (nonatomic, copy) NSString *JGNO;             //机构代码
@property (nonatomic, copy) NSString *Tonnage;          //吨位
@property (nonatomic, copy) NSString *CNTRNO;           //柜号
@property (nonatomic, copy) NSString *CNTRKG;           //柜重
@property (nonatomic, copy) NSString *VINNO;            //架号
@property (nonatomic, copy) NSString *VINKG;            //架重
@property (nonatomic, copy) NSString *BrandHead;        //牌头
@property (nonatomic, copy) NSString *TravelLicenseUrl; //驾驶证链接

@end

NS_ASSUME_NONNULL_END
