//
//  LockDBManager.h
//  HZBitSmartLock
//
//  Created by Apple on 2018/6/25.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

UIKIT_EXTERN NSString *const kLockMac;
UIKIT_EXTERN NSString *const kLockName;
UIKIT_EXTERN NSString *const kLockProvince;
UIKIT_EXTERN NSString *const kLockCity;
UIKIT_EXTERN NSString *const kLockDistrict;
UIKIT_EXTERN NSString *const kLockCommunity;
UIKIT_EXTERN NSString *const kLockStreet;

typedef void (^queryALLDataBlock) (NSMutableArray *array);

@interface LockDBManager : NSObject

+ (LockDBManager*)sharedInstance;

- (void)insertData:(NSString *)name  mac:(NSString *)mac province:(NSString *)province city:(NSString *)city district:(NSString *)district community:(NSString *)community street:(NSString *)street th:(NSString *)thoroughfare code:(NSString *)communityCode;
- (void)update:(NSString *)mac key:(NSString *)key value:(NSString *)value;
- (NSMutableArray *)queryALLData:(queryALLDataBlock)block;

@end
