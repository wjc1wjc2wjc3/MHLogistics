//
//  DelDDYOneSJInfoViewModel.h
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZBitViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DelDDYOneSJInfoViewModel : HZBitViewModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSURLSessionDataTask *)startRequest:(NSDictionary *)param;
@end

NS_ASSUME_NONNULL_END
