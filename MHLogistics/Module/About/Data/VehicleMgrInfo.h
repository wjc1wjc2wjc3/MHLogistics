//
//  VehicleMgrInfo.h
//  MHLogistics
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VehicleMgrInfo : NSObject

@property (nonatomic, copy) NSString *licensePlate;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *ton;
@property (nonatomic, copy) NSString *time;

@end

NS_ASSUME_NONNULL_END
