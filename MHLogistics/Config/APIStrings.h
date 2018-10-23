//
//  APIStrings.h
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#ifndef APIStrings_h
#define APIStrings_h


static NSString* const URI_BASE_SERVER_HTTPS =  @"https://elock.hzbit.com/lockadmin/user/v2/";
static NSString* const URI_BASE_SERVER2      =  @"http://192.168.11.100:8090/lockadmin/user/v2/";  //开发本地服
static NSString* const URI_BASE_SERVER4      =  @"http://222.46.27.215:41224/lockadmin/user/v2/";  //外网测试服
static NSString* const URI_BASE_SERVER5      =  @"http://192.168.10.214:8080/lockadmin/user/v2/";  //本地测试服
static NSString* const URI_BASE_SERVER6      =  @"http://192.168.10.214:8080/lockadmin/expires/";
static NSString* const URI_BASE_SERVER7      =  @"http://192.168.11.250:8080/lockadmin/expires/";
static NSString* const URI_BASE_SERVER8      =  @"http://47.98.102.39:8080/lockadmin/user/v2/";
static NSString* const URI_BASE_SERVER9      =  @"http://47.98.102.39:8080/lockadmin/expires/";
static NSString* const URI_REQUEST           =  URI_BASE_SERVER8;
static NSString* const PAY_URI_REQUEST       =  URI_BASE_SERVER9;
static NSString* const URI_ROOT = @"";

static NSString* const Register                 = @"register";                  //注册
static NSString* const Login                    = @"login";                     //登录
static NSString* const GetUserInfo              = @"getUserInfo";               //获取用户信息
static NSString* const AuthAssignment           = @"authAssignment";            //转让权限
static NSString* const GetSmsCode               = @"getSmsCode";                //获取验证码
static NSString* const LockInfo                 = @"getLockInfo";               //获取锁信息
static NSString* const GetAuthDetail            = @"getAuthDetail";             //获取锁详情
static NSString* const BindLock                 = @"bindLock";                  //锁绑定用户
static NSString* const UnbindLock               = @"unbindLock";                //解除绑定
static NSString* const LockList                 = @"getLockList";               //获取门锁列表信息
static NSString* const UpdateClientId           = @"updateClientId";            //更新个推
static NSString* const AccountVerify            = @"accountVerify";             //实名验证(预留)
static NSString* const GetParaByOCR             = @"getParaByOCR";              //OCR获取身份证参数
static NSString* const IdenVerification         = @"idenVerification";          //身份核验
static NSString* const IdenVerificationV2       = @"idenVerificationV2";        //身份核验
static NSString* const AuthIdcard               = @"authIdcard";                //门锁授权
static NSString* const ShareLock                = @"shareLock";                 //分享授权
static NSString* const ChangePwd                = @"changePwd";                 //修改密码
static NSString* const ChangePwd2               = @"changePwd2";                 //修改密码
static NSString* const GetSysConfig             = @"getSysConfig";              //修改密码
static NSString* const GetAuthIdcardList        = @"getAuthIdcardList";         //获取身份证授权列表
static NSString* const GetLockShareList         = @"getLockShareList";          //获取门锁授权列表
static NSString* const DeleteAuthIdcard         = @"deleteAuthIdcard";          //删除门锁分享
static NSString* const DeleteLockShare          = @"deleteLockShare";           //删除分享
static NSString* const UploadLockOpenRecord     = @"uploadLockOpenRecord";      //开门记录上报
static NSString* const GetAuthIdcardInfo        = @"getAuthIdcardInfo";         //获取身份证授权列表
static NSString* const ImgLogin                 = @"imgLogin";                  //百度人脸对比
static NSString* const UploadLockOpenRecordList = @"uploadLockOpenRecordList";  //上传开门记录列表
static NSString* const GetIdentityInfo          = @"getIdentityInfo";           //获取身份证授权列表
static NSString* const GiveBackAuthority        = @"giveBackAuthority";         //退还管理者权限

static NSString* const GetProvince              = @"getProvince";               //获取省
static NSString* const GetCity                  = @"getCity";                   //获取城市
static NSString* const GetDistrict              = @"getDistrict";               //获取区
static NSString* const GetStreet                = @"getStreet";                 //获取街道
static NSString* const GetCommunity             = @"getCommunity";              //获取社区
static NSString* const GetSubdistrictByDivision = @"getSubdistrictByDivision";  //获取小区
static NSString* const GetStreetBySubdistrict   = @"getStreetBySubdistrict";    //获取小区的具体信息
static NSString* const AddSubdistrictByName     = @"addSubdistrictByName";      //添加新地址
static NSString* const AddLocationV2            = @"addLocationV2";             //添加新地址
static NSString* const GetLocation              = @"getLocation";               //获取巷
static NSString* const AddLocation              = @"addLocation";               //获取社区

static NSString* const RenameCardAlias          = @"renameCardAlias";           //修改别名
static NSString* const LoginBySms               = @"loginBySms";                //短信登录
static NSString* const LoginByFace              = @"loginByFace";               //刷脸登录
static NSString* const LoginFaceCheck           = @"loginFaceCheck";            //刷脸登录
static NSString* const ExtendAuthDate           = @"extendAuthDate";            //延期
static NSString* const GetOpenRecordList        = @"getOpenRecordList";         //获取开门记录
static NSString* const GetUnbindDetail          = @"getUnbindDetail";           //扫一扫解绑

static NSString* const GetLockUpdateInfo        = @"getLockUpdateInfo";         //获取锁设备升级
static NSString* const GetLockUpdateInfo2       = @"getLockUpdateInfo2";         //获取锁设备升级
static NSString* const ChangeLockSettings       = @"changeLockSettings";        //修改锁设置
static NSString* const VerifyTemp               = @"verifyTemp";                //身份证照片和手持身份证照片核验
static NSString* const CheckBioAssay            = @"checkBioAssay";             //活体检测
static NSString* const AuthRoutine              = @"authRoutine";               //单次授权

static NSString* const GetLockAbc               = @"getLockAbc";               //根据锁mac获取密钥
static NSString* const GetLockListWithMac       = @"getLockListWithMac";       //根据锁mac获取锁列表
static NSString* const GetLockListByMac         = @"getLockListByMac";         //根据锁mac获取锁列表
static NSString* const UpdateLockName           = @"updateLockName";           //更新锁名称
static NSString* const GetDepositInfoAli        = @"getDepositInfoAli";        //支付宝支付信息
static NSString* const AliCallBack              = @"aliCallBack";              //支付宝支付成功回调
static NSString* const LoginPwdCheck            = @"loginPwdCheck";            //验证登录密码

static NSString* const GetLockShareWxList       = @"getLockShareWxList";       //单次授权列表
static NSString* const GetLockListWithMac2      = @"getLockListWithMac2";      //验证登录密码

static NSString* const UploadLockORLH           = @"uploadLockOpenRecordListHistory";      //上传离线开门记录
static NSString* const CheckMidbByIOS           = @"checkMidbByIos";                       //获取mid
static NSString* const GetServiceProducts       = @"getServiceProducts";      //获取商品
static NSString* const GetPreBillOrder          = @"getPreBillOrder";      //获取mid


//百度人脸对比URL
static NSString *const BaiduFaceURL = @"https://aip.baidubce.com/rest/2.0/face/v2/match";
//获取人脸对比Token
static NSString *const BaiduTokenURL = @"https://aip.baidubce.com/oauth/2.0/token";

//支付相关
static NSString* const PayGetLockList          = @"getLockList";         //获取锁列表
static NSString* const PayGetLockExpires       = @"getLockExpires";      //获取单锁信息
static NSString* const PayGetPreBillOrder      = @"getPreBillOrder";     //服务费 获取支付预订单
static NSString* const GetPreDepositOrder      = @"getPreDepositOrder";     //押金 获取支付预订单
#endif /* APIStrings_h */
