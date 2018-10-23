//
//  CRCUtils.h
//  HZBitSmartLock
//
//  Created by Apple on 10/23/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRCUtils : NSObject

+ (NSString *)caculateCRC:(NSString *)src;
+ (NSString *)createCRC:(NSString *)format, ...;
+ (NSString *)bitSum:(NSString *)src add:(NSString *)addtion;

@end
