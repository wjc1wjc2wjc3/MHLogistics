//
//  PayResultApp.h
//  HZBitSmartLock
//
//  Created by Apple on 2018/9/13.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayResultApp : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *app_id;
@property (nonatomic, copy) NSString *auth_app_id;
@property (nonatomic, copy) NSString *charset;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *total_amount;
@property (nonatomic, copy) NSString *trade_no;
@property (nonatomic, copy) NSString *seller_id;
@property (nonatomic, copy) NSString *out_trade_no;

- (instancetype)initWithString:(NSString *)jsonString;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
