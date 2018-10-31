//
//  HZBitRouter.m
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "HZBitRouter.h"

@interface HZBitRouter ()

@property (nonatomic, copy) NSDictionary *viewModelViewMappings; // viewModel到view的映射

@end

@implementation HZBitRouter

+ (instancetype)sharedInstance {
    static HZBitRouter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (HZBitViewController *)viewControllerForViewModel:(MXBitViewModel *)viewModel {
    NSString *viewController = self.viewModelViewMappings[NSStringFromClass(viewModel.class)];
    
    NSParameterAssert([NSClassFromString(viewController) isSubclassOfClass:[HZBitViewController class]]);
    NSParameterAssert([NSClassFromString(viewController) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
}

- (void)showMainHomeVC {
    
}


- (NSDictionary *)viewModelViewMappings {
    return @{
             @"HomeViewModel": @"HomeViewController",
             @"LoginViewModel": @"LoginViewController",
             @"RegisterViewModel": @"RegisterViewController",
             };
}

@end
