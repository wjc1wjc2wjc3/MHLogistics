//
//  NSString+LittleEndian.h
//  HZBitSmartLock
//
//  Created by Apple on 30/11/2017.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LittleEndian)

+ (NSMutableArray *)littleEndianArray:(NSString *)src ;
+ (NSString *)littleEndian:(NSString *)src;

/*
 @param
 @returm NO 当前的服务器版本号大于锁的版本号，YES 相反
 */
+ (BOOL)compareVersion:(NSString *)serverVersion local:(NSString *)lockVersion;
@end
