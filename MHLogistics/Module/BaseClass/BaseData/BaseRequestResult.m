//
//  BaseRequestResult.m
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "BaseRequestResult.h"

@implementation BaseRequestResult

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    BaseRequestResult *bRR = [BaseRequestResult mj_objectWithKeyValues:dictionary];
    return bRR;
}

@end
