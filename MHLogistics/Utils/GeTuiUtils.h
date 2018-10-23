//
//  GeTuiUtils.h
//  HZBitSmartLock
//
//  Created by Apple on 19/01/2018.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const kGeTuiClientID;

@interface GeTuiUtils : NSObject

+ (void)setClientId:(NSString *)clientId;
+ (NSString *)getClientId;

@end
