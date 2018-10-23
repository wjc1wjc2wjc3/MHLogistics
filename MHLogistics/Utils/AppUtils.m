//
//  AppUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 26/03/2018.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "AppUtils.h"

static NSString *kAppVersion = @"";
static NSString *kBundleIdentifier = @"";

@implementation AppUtils

+ (NSString *)appVersion {
    if ([@"" isEqualToString:kAppVersion]) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *appVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
        kAppVersion = [NSString stringWithFormat:@"版本 %@ Build %@", appCurVersion, appVersion];
    }
    return kAppVersion;
}

+ (NSString *)bundleIdentifier {
    if ([@"" isEqualToString:kBundleIdentifier]) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *bundleIdentifier = [infoDictionary objectForKey:@"CFBundleIdentifier"];
        kBundleIdentifier = [NSString stringWithFormat:@"%@", bundleIdentifier];
    }
    return kBundleIdentifier;
}

@end
