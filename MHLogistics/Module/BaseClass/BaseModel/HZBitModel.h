//
//  HZBitModel.h
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "AESCryptUtils.h"

@interface HZBitModel : NSObject

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *token;

- (void)setToken:(NSString *)token;

- (NSDictionary *)dictionary;

@end
