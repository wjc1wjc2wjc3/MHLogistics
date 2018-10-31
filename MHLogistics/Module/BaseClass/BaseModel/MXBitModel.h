//
//  MXBitModel.h
//  MHLogistics
//
//  Created by Apple on 2018/10/31.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EnumUType) {
    eDispatcher = 0x01,    //调度员
    eHKDrive,             //香港司机
    eHorseman,            //骑士
    eSingleDrive,         //单头司机
};

@interface MXBitModel : NSObject

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *token;

- (void)setToken:(NSString *)token;

- (NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
