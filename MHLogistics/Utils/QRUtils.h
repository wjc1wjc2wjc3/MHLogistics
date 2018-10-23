//
//  QRUtils.h
//  HZBitSmartLock
//
//  Created by Apple on 11/1/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRUtils : NSObject

+ (BOOL)isQrCodeDataValid:(NSString *)qrCodeStr;

@end
