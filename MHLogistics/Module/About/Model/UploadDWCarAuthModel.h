//
//  UploadDWCarAuthModel.h
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "HZBitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UploadDWCarAuthModel : HZBitModel

@property (nonatomic, copy) NSString *CarType;          //车辆类型，1自备货柜，2吨位车
@property (nonatomic, copy) NSString *HkNO;             //香港车牌号
@property (nonatomic, copy) NSString *DlNO;             //大陆车牌号
@property (nonatomic, copy) NSString *CIQID;            //海关备案号
@property (nonatomic, copy) NSString *ICNO;             //IC卡号
@property (nonatomic, copy) NSString *JGNO;             //机构代码
@property (nonatomic, copy) NSString *Tonnage;          //吨位
@property (nonatomic, copy) NSString *FBDLNO;           //封闭道路通行证号
@property (nonatomic, copy) NSString *BrandHead;        //牌头
@property (nonatomic, copy) NSString *CarSize;          //车辆长宽高，格式为：长*宽*高


@end

NS_ASSUME_NONNULL_END
