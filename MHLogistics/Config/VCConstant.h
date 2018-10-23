//
//  VCConstant.h
//  HZBitSmartLock
//
//  Created by Apple on 11/12/2017.
//  Copyright © 2017 HZBit. All rights reserved.
//

#ifndef VCConstant_h
#define VCConstant_h

typedef NS_ENUM(NSUInteger, VCType) {
    eAuthShare                                      = 0,       //锁分享
    eAuthIdentity                                      ,          //授权身份证
    eAuthKeyCard                                       ,          //授权钥匙卡
    eOpenDoor                                          ,          //列表进入开门
    eOpenDoorHome                                      ,          //主页进入开门
    eUpdateLock                                        ,          //锁升级
    eChangeLockConfig                                  ,          //更改锁配置
    eSynchronizedIdentity                              ,          //同步身份证授权
    eSynchronizedIdentityAfterTakeIdentifyPhoto        ,          //同步身份证授权在完成身份证正反面拍照后 / TCP读完授权身份证的信息之后
    eSynchronizedIdentityAfterTCPTransmission          ,          //身份证数据通过TCP完成后同步数据
    eSynchronizedKeyCard                               ,          //同步钥匙卡
    eFirmwareUpdateLock                                ,          //外设固件升级
    eLoraUpdateLock                                    ,          //lora升级
    eSingleAuthShare                                   ,          //单次授权分享
    eSynchronizedData                                  ,          //同步数据
    eShowDevice                                        ,          //显示设备页面
    eServiceRecharge                                               //充值页面
};


typedef NS_ENUM(NSUInteger, CardType) {
    identityCard = 1,   //身份证
    lockAccessCard, //门禁卡
};

#endif /* VCConstant_h */
