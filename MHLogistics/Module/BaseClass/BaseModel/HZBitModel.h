//
//  HZBitModel.h
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "AESCryptUtils.h"

typedef NS_ENUM(NSUInteger, EnumUType) {
    eDispatcher = 0x01,    //调度员
    eHKDrive,             //香港司机
    eHorseman,            //骑士
    eSingleDrive,         //单头司机
};


@interface HZBitModel : NSObject

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *token;

- (void)setToken:(NSString *)token;

- (NSDictionary *)dictionary;

@end
