//
//  MXBitModel.m
//  MHLogistics
//
//  Created by Apple on 2018/10/31.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "MXBitModel.h"

@implementation MXBitModel

- (void)setToken:(NSString *)token {
    if (token) {
        _token = token;
    }
}

- (NSDictionary *)dictionary {
    return [self mj_keyValues];
}

@end
