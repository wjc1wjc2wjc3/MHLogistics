//
//  DelDDYOneSJInfoViewModel.h
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXBitViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DelDDYOneSJInfoViewModel : MXBitViewModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSURLSessionDataTask *)startRequest:(NSDictionary *)param;
@end

NS_ASSUME_NONNULL_END
