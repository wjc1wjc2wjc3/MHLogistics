//
//  NSString+MD5.m
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString (MD5)

- (NSString *)md5_32bit {
    
    const char * str = [self UTF8String];
    unsigned char md[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (int)strlen(str), md);
    NSMutableString * ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",md[i]];
    }
    
    return ret;
}


@end
