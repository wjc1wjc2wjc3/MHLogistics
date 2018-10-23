//
//  PayResponseApp.h
//  HZBitSmartLock
//
//  Created by Apple on 2018/9/13.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayResultApp.h"

@interface PayResponseApp : NSObject

@property (nonatomic, strong) PayResultApp *pra;
@property (nonatomic, weak) NSDictionary *alipay_trade_app_pay_response;

- (instancetype)initWithString:(NSString *)jsonString;

@end
