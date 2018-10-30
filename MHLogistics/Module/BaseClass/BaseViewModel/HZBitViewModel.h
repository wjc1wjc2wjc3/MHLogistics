//
//  HZBitViewModel.h
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//


#import "APIManager.h"
#import "AESCryptUtils.h"
#import "GTMBase64.h"
#import "NSData+Add.h"
#import "TimeUtils.h"


@class HZBitViewModel;

typedef void (^BitSuccessBlock) (HZBitViewModel *returnValue);
typedef void (^BitErrorCodeBlock) (NSString *errorCode);
typedef void (^BitFailureBlock)(HZBitViewModel *errorCode);

@interface HZBitViewModel : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) BitSuccessBlock bitSuccessBlock;
@property (nonatomic, copy) BitErrorCodeBlock bitErrorCodeBlock;
@property (nonatomic, copy) BitFailureBlock bitFailureBlock;

- (NSString *)formatUrl:(NSString *)funcName;

@end
