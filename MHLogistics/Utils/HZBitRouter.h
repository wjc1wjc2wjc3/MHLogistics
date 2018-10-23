//
//  HZBitRouter.h
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZBitViewController.h"

@interface HZBitRouter : NSObject

+ (instancetype)sharedInstance;


- (HZBitViewController *)viewControllerForViewModel:(HZBitViewModel *)viewModel;

@end
