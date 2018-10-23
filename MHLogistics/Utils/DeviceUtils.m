//
//  DeviceUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 23/01/2018.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "DeviceUtils.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
#import "AccountUtils.h"

//系统版本
static NSString *version = @"";

//品牌
static NSString *model = @"";

//vendor值
static NSString *vendor = @"";

//idfa
static NSString *idfaLocal = @"";

//systemName
static NSString *systemName = @"";

//name
static NSString *name = @"";

static NSString *deviceModel = @"";

static NSString *iPhoneX = @"";

@implementation DeviceUtils

+(NSString *)systemVersion {
    if ([@"" isEqualToString:version]) {
        version = [[UIDevice currentDevice] systemVersion];
    }
    
    return version;
}

+(NSString *)localizedModel {
    if ([@"" isEqualToString:model]) {
        model = [[UIDevice currentDevice] localizedModel];
    }
    
    return model;
}

+ (NSString *)identifierForVendor {
    if ([@"" isEqualToString:vendor]) {
        NSUUID *vendorUUID = [[UIDevice currentDevice] identifierForVendor];
        if (vendorUUID) {
            vendor = [vendorUUID UUIDString];
        }
    }
    
    return vendor;
}

+ (NSString *)idfaString {
    if ([idfaLocal isEqualToString:@""]) {
        NSString *saveIDFA = [AccountUtils getIDFA];
        NSString *idfa = @"";
        if (saveIDFA && ![@"" isEqualToString:saveIDFA]) {
            idfa = [saveIDFA mutableCopy];
        }
        else
        {
            idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
            if ([@"00000000-0000-0000-0000-000000000000" isEqualToString:idfa]) {
                
                NSString *saveIDFA = [AccountUtils getIDFA];
                if (saveIDFA) {
                    idfa = [saveIDFA mutableCopy];
                }
                else
                {
                    NSString *vendor = [self identifierForVendor];
                    [AccountUtils saveIDFA:vendor];
                    idfa = [vendor mutableCopy];
                }
            }
            else
            {
                [AccountUtils saveIDFA:idfa];
            }
        }
        
        idfaLocal = idfa;
    }
    return idfaLocal;
}

+ (NSString *)systemName {

    if ([systemName isEqualToString:@""]) {
         systemName = [[UIDevice currentDevice] systemName];
    }
    
    return systemName;
}

+ (NSString *)localizedName {
    if ([name isEqualToString:@""]) {
        name = [[UIDevice currentDevice] name];
    }
    
    return name;
}

+ (NSString *)iPhoneType
{

    if ([@"" isEqualToString:deviceModel]) {
        struct utsname systemInfo;
        uname(&systemInfo);
        deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    }
    return deviceModel;
}

+ (BOOL )isiPhoneX {
    NSString *deviceModel  = [self iPhoneType];
    if ([@"" isEqualToString:iPhoneX]) {
        if ([deviceModel hasPrefix:@"x86_64"] ||
            [deviceModel hasPrefix:@"iPhone10"]) {
            iPhoneX = @"1";
        }
        else
        {
            iPhoneX = @"0";
        }
    }
    
    return [iPhoneX isEqualToString:@"1"];
}

@end
