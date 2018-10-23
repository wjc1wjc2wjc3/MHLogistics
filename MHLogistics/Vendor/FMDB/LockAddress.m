//
//  LockAddress.m
//  HZBitSmartLock
//
//  Created by Apple on 2018/6/25.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "LockAddress.h"

@implementation LockAddress

-(instancetype)initDictionary:(NSDictionary *)dict {
    LockAddress *entity = [LockAddress mj_objectWithKeyValues:dict];
    return entity;
}

@end
