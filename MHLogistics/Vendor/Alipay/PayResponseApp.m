//
//  PayResponseApp.m
//  HZBitSmartLock
//
//  Created by Apple on 2018/9/13.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "PayResponseApp.h"

@implementation PayResponseApp

- (instancetype)initWithString:(NSString *)jsonString {
    PayResponseApp *pRA = [PayResponseApp mj_objectWithKeyValues:jsonString];
    if (pRA.alipay_trade_app_pay_response) {
        pRA.pra = [[PayResultApp alloc] initWithDict:pRA.alipay_trade_app_pay_response];
    }
    return pRA;
}

@end
