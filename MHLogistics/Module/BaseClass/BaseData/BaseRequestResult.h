//
//  BaseRequestResult.h
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseRequestResult : NSObject

@property (nonatomic, copy) NSString *CurTime; //
@property (nonatomic, copy) NSString *Code;   //
@property (nonatomic, copy) NSString *Msg;   //

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
