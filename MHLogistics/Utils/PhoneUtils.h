//
//  PhoneUtils.h
//  HZBitSmartLock
//
//  Created by Apple on 10/31/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneUtils : NSObject


+ (NSString *)phoneConvertText:(NSString *)text;

/**
 * @brief 在规定的起始位置和最终位置 中间使用指定的字符替代
 * @param text  原始字符
 * @param startPos  开始替换字符的位置
 * @param endPos    结束替换字符的位置
 */
+ (NSString *)convertText:(NSString *)text start:(NSInteger)startPos end:(NSInteger)endPos;

@end
