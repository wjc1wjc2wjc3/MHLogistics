//
//  MXBitViewModel.h
//  MHLogistics
//
//  Created by Apple on 2018/10/31.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManager.h"
#import "AESCryptUtils.h"
#import "GTMBase64.h"
#import "NSData+Add.h"
#import "TimeUtils.h"
NS_ASSUME_NONNULL_BEGIN

@class MXBitViewModel;

typedef void (^BitSuccessBlock) (MXBitViewModel *returnValue);
typedef void (^BitErrorCodeBlock) (NSString *errorCode);
typedef void (^BitFailureBlock)(MXBitViewModel *errorCode);

@interface MXBitViewModel : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) BitSuccessBlock bitSuccessBlock;
@property (nonatomic, copy) BitErrorCodeBlock bitErrorCodeBlock;
@property (nonatomic, copy) BitFailureBlock bitFailureBlock;

- (NSString *)formatUrl:(NSString *)funcName;

@end

NS_ASSUME_NONNULL_END
