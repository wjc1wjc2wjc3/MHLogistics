//
//  HomeData.h
//  MHLogistics
//
//  Created by wjc on 10/27/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeData : NSObject

@property (nonatomic, copy) NSString *licenseP;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *timeNow;
@property (nonatomic, strong) NSMutableArray *typeArray;

@property (nonatomic, copy) NSString *ton;
@property (nonatomic, copy) NSString *loading;
@property (nonatomic, copy) NSString *clearance;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *loadingAddress;
@property (nonatomic, copy) NSString *unloadAddress;
@end
