//
//  APIStrings.h
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#ifndef APIStrings_h
#define APIStrings_h


static NSString* const URI_SERVER =  @"https://120.77.251.136/dp/api/user/";

static NSString* const URI_REQUEST           =  URI_SERVER;

static NSString* const URI_ROOT = @"";

static NSString* const kRegister                     = @"register";                  //注册
static NSString* const kLogin                        = @"login";                     //登录
static NSString* const kQuery                        = @"query";                     //查询 get
static NSString* const kResetpwd                     = @"resetpwd";                  //重置密码
static NSString* const kLogout                       = @"logout";                    //注销
static NSString* const kUploadDDYAuthInfo            = @"UploadDDYAuthInfo";         //上传调度员认证信息
static NSString* const kUploadDTAuthInfo             = @"UploadDTAuthInfo";          //上传单头司机认证信息
static NSString* const kUploadHKSJAuthInfo           = @"UploadHKSJAuthInfo";        //上传香港司机认证信息
static NSString* const kUploadDLSJAuthInfo           = @"UploadDLSJAuthInfo";        //上传骑士认证信息
//用户认证 -上传认证照片
static NSString* const kUploadUserAuthPhoto          = @"UploadUserAuthPhoto?type=%d&fileExtension=%d&isFront=%d&sjId=";
static NSString* const kGetUserAuthInfo              = @"GetUserAuthInfo";           //获取认证信息 get
static NSString* const kUploadZBCarAuth              = @"UploadZBCarAuth";           //车辆认证-自备货柜 新增、修改通用
static NSString* const kUploadDWCarAuth              = @"UploadDWCarAuth";           //车辆认证-吨位车辆（新增、修改通用）

//车辆认证 -上传行驶证照片（新增、修改通用）
static NSString* const kUploadCarMgrTLPhoto          = @"UploadCarMgrTLPhoto?carId=%@&fileExtension=%@";
static NSString* const kDelDDYCar                    = @"DelDDYCar";                  //删除车辆
static NSString* const kGetAllCarMgrInfo             = @"GetAllCarMgrInfo";           //获取所有认证车辆
static NSString* const kGetAllDDYSjInfo              = @"GetAllDDYSjInfo";            //调度员获取司机列表 get
static NSString* const kGetDDYOneSJInfo              = @"GetDDYOneSJInfo?sjid=%ld";   //获取对应司机信息 get
static NSString* const kDelDDYOneSJInfo              = @"DelDDYOneSJInfo?sjid=%ld";   //-删除司机


//百度人脸对比URL
static NSString *const BaiduFaceURL = @"https://aip.baidubce.com/rest/2.0/face/v2/match";
//获取人脸对比Token
static NSString *const BaiduTokenURL = @"https://aip.baidubce.com/oauth/2.0/token";

#endif /* APIStrings_h */
