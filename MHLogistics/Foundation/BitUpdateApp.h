//
//  BitUpdateApp.h
//  HZBitSmartLock
//
//  Created by Apple on 2018/6/26.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BitUpdateApp : NSObject

typedef void(^UpdateBlock)(NSString *currentVersion,NSString *storeVersion, NSString *openUrl,BOOL isUpdate);

+(void)bit_updateWithAPPID:(NSString *)appId withBundleId:(NSString *)bundelId block:(UpdateBlock)block;

@end
