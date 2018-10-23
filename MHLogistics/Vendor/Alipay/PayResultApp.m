//
//  PayResultApp.m
//  HZBitSmartLock
//
//  Created by Apple on 2018/9/13.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "PayResultApp.h"

@implementation PayResultApp

- (instancetype)initWithString:(NSString *)jsonString {
    PayResultApp *pRA = [PayResultApp mj_objectWithKeyValues:jsonString];
    return pRA;
}


- (instancetype)initWithDict:(NSDictionary *)dict {
    PayResultApp *pRA = [PayResultApp mj_objectWithKeyValues:dict];
    return pRA;
}

@end
