//
//  ViewControllerUtils.h
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZNavViewController.h"

@interface ViewControllerUtils : NSObject

+ (UIViewController *)currentViewController;
+ (HZNavViewController *)currentPopViewController;
+ (void)showHomeViewController;

+ (void)showLoginViewController;

+ (void)showLaunscreenViewController;


+ (void)popToHomeVC:(UIViewController *)viewController;

@end
