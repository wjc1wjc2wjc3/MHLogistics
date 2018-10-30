//
//  HZBitViewModel.m
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "HZBitViewModel.h"

@implementation HZBitViewModel

- (NSString *)formatUrl:(NSString *)funcName {
    return [NSString stringWithFormat:@"%@%@", URI_REQUEST, funcName];
}

@end
