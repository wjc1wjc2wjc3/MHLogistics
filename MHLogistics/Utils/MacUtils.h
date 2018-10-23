//
//  MacUtils.h
//  HZBitSmartLock
//
//  Created by Apple on 06/01/2018.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MacUtils : NSObject

+ (NSString *)createMacAddress:(NSString *)mac;
+ (NSString *)getMac:(NSString *)scanData;
@end
