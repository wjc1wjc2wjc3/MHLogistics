//
//  HZBitModel.m
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "HZBitModel.h"

@implementation HZBitModel

- (void)setToken:(NSString *)token {
    if (token) {
        _token = token;
    }
}

- (NSDictionary *)dictionary {
    return [self mj_keyValues];
}

@end
