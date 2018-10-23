//
//  TimeUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 12/04/2018.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "TimeUtils.h"

@implementation TimeUtils

+(NSString *)getTimeStamp {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", lround(time)];
    return timeStamp;
}
@end
