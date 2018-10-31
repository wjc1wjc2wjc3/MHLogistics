//
//  MXBitViewModel.m
//  MHLogistics
//
//  Created by Apple on 2018/10/31.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "MXBitViewModel.h"

@implementation MXBitViewModel

- (NSString *)formatUrl:(NSString *)funcName {
    return [NSString stringWithFormat:@"%@%@", URI_REQUEST, funcName];
}

@end
