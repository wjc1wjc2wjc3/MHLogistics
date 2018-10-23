//
//  GeTuiUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 19/01/2018.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "GeTuiUtils.h"

static NSString *localClientId = @"";

NSString *const kGeTuiClientID = @"GeTuiClientID";

@implementation GeTuiUtils

+ (void)setClientId:(NSString *)clientId {
    localClientId = clientId;
}

+ (NSString *)getClientId {
    return localClientId;
}

@end
