//
//  QueryResultData.h
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "BaseRequestResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface QueryResultData : BaseRequestResult
@property (nonatomic, copy) NSString *UType;   //
@property (nonatomic, copy) NSString *Phone;   //
@property (nonatomic, copy) NSString *AccessToken;   //
@property (nonatomic, copy) NSString *RefreshToken;   //
@property (nonatomic, copy) NSString *NextQueryMin;
@end

NS_ASSUME_NONNULL_END
