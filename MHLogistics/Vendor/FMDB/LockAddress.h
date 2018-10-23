//
//  LockAddress.h
//  HZBitSmartLock
//
//  Created by Apple on 2018/6/25.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LockAddress : NSObject

@property (nonatomic, copy) NSString *LockName;
@property (nonatomic, copy) NSString *LockMac;
@property (nonatomic, copy) NSString *LockProvince;
@property (nonatomic, copy) NSString *LockCity;
@property (nonatomic, copy) NSString *LockDistrict;
@property (nonatomic, copy) NSString *LockCommunity;
@property (nonatomic, copy) NSString *LockStreet;
@property (nonatomic, copy) NSString *thoroughfare;
@property (nonatomic, copy) NSString *CommunityCode;

-(instancetype)initDictionary:(NSDictionary *)dict;

@end
