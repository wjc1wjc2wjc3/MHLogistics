//
//  Config.h
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define ARGB(a,b,c,al) [UIColor colorWithRed:(a/255.0) green:(b/255.0) blue:(c/255.0) alpha:(al)]
#define RGB(a,b,c) [UIColor colorWithRed:(a/255.0) green:(b/255.0) blue:(c/255.0) alpha:1.0]

#define VERIFY_CODE_DURATION 60

#define iPhoneX_Bang_Height 50

#define OFFLINEORRECORDCACHEPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/OfflineOpendoorRecord.plist"]

#define BLUECACHEPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/Advertise.plist"]
#define USERINOPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/UserInfo.data"]
#define arUserInfo(a) [NSKeyedArchiver archiveRootObject:(a) toFile:USERINOPATH]
#define unArchUserInfo [NSKeyedUnarchiver unarchiveObjectWithFile:USERINOPATH]

#define OCRINFOPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/OCRInfo.data"]
#define arOCRInfo(a) [NSKeyedArchiver archiveRootObject:(a) toFile:OCRINFOPATH]
#define unArchOCRInfo [NSKeyedUnarchiver unarchiveObjectWithFile:OCRINFOPATH]

#define FIREAREWAREUPDATESERVERPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/FirewareUpdateServer.data"]
#define arFirewareUpdateServer(a) [NSKeyedArchiver archiveRootObject:(a) toFile:FIREAREWAREUPDATESERVERPATH]
#define unArchFirewareUpdateServer [NSKeyedUnarchiver unarchiveObjectWithFile:FIREAREWAREUPDATESERVERPATH]

#define FIREAREWAREDATAUPDATEPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/FirewareDataUpdateServer.data"]
#define arFirewareDataUpdate(a) [NSKeyedArchiver archiveRootObject:(a) toFile:FIREAREWAREDATAUPDATEPATH]
#define unArchFirewareDataUpdate [NSKeyedUnarchiver unarchiveObjectWithFile:FIREAREWAREDATAUPDATEPATH]

#define IOS_VERSION [[UIDevice currentDevice] systemVersion]

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define BAIDUTOKENDATAPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/BaiduTokenData.data"]
#define arBaiduTokenData(a) [NSKeyedArchiver archiveRootObject:(a) toFile:BAIDUTOKENDATAPATH]
#define unArchBaiduTokenData [NSKeyedUnarchiver unarchiveObjectWithFile:BAIDUTOKENDATAPATH]

#define  DEBUG_MODE 0

#ifdef DEBUG
#define DLog( s, ... ) NSLog( @" %@",[NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... ) NSLog( @" %@",[NSString stringWithFormat:(s), ##__VA_ARGS__] )
#endif

#define kIntroduceUrl @"https://elock.hzbit.com/file/test.html"
#define kOperationUrl @"http://a3.rabbitpre.com/m2/aUe1ZiAucX?&lc=1&sui=5dd98349-0c42-4180-b2ad-08b6544d94ce#from=share"
#define kAppStoreUrl @"https://itunes.apple.com/cn/app/e%E9%94%81/id1315580393?mt=8"

#define kOpenDoorWaitTime 5.0

#define kGtAppId           @"4VoILMMbCZ9bVBLJ7ff2A8"
#define kGtAppKey          @"YGPVRlojSh61L9UuRqOyx1"
#define kGtAppSecret       @"AGZpHmTZ1d8gkoX1b89RW6"

#define kCornerRadius   5.0

//是否使用固定加密 0 不使用 1 使用
#define kUserFixKey 1

#define NoCertificate 1    //是否是打无证书的企业版本 测试汪竟成

#define Product_test 0  //是否是生产测试版, com.hzbit.app.test

#define kRealIdentify 0  //是否打开实名认证

#define kZhiFuBao 1  //打开支付宝
#define kOpenMyAccount 1  //打开支付宝

//是否打开透传数据
#define kOpenPassThroughData 1
//tcp数据的传输模式
#define kTCPDNMode 0

#ifdef NoCertificate
//for bundId com.hzbit.app.HZBitApp
#define kBaiduKey        @"8omVcKt1Plu4jxxwdoXSApGq"
#define kBaiduSecretKey  @"XpYGwezLngO9w5tnxGH7fGf7x880hDiG"
#define kBaiduApi        @"aipHZBitApp"

#else
//for bundId com.hzbit.app.lock
#define kBaiduKey        @"gBZycTHh2WIzBU5yaUo4OcGj"
#define kBaiduSecretKey  @"XqwWdwqjgu6DT3d8j3rv7tdQpmRHdImV"
#define kBaiduApi        @"aip"
#endif

//时间选择的长期
#define LONG_TERM 2145888000

#define ELockWeakSelf()        __weak typeof (self) weakSelf = self
#define ELockStrongSelf()        __typeof__(self) strongSelf = weakSelf;
//人脸对比成功的阙值
#define kFaceCompareThreshold 50



#endif /* Config_h */
