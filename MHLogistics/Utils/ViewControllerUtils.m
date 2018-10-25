//
//  ViewControllerUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "ViewControllerUtils.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "HZNavViewController.h"
#import "HomeViewController.h"
#import "HZBitRouter.h"

@implementation ViewControllerUtils

+ (UIViewController *)currentViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
        
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc visibleViewController];
        } else if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}

+ (HZNavViewController *)currentPopViewController {
    MainViewController *popVC = (MainViewController *)[self currentViewController];
    if (popVC) {
        NSArray *vcArray = popVC.viewControllers;
        HZNavViewController *subVC = (HZNavViewController *)vcArray[popVC.selectedIndex];
        return subVC;
    }
    
    return nil;
}


+(void)showHomeViewController {
    MainViewController *mainVC = [[MainViewController alloc] init];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = mainVC;
    [keyWindow makeKeyAndVisible];
}

+ (void)showLaunscreenViewController {
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateInitialViewController];

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = viewController;
    [keyWindow makeKeyAndVisible];
    
    NSArray *subviews = viewController.view.subviews;
    UIImageView *imageView = subviews[0];
    [viewController.view bringSubviewToFront:imageView];
    CATransform3D start = CATransform3DMakeRotation(-45 * M_PI / 180.0, 0, 0, 1);
    CATransform3D end = CATransform3DMakeRotation(45 * M_PI / 180.0, 0, 0, 1);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:start];
    animation.toValue = [NSValue valueWithCATransform3D:end];
    animation.duration = 0.5;
    animation.autoreverses = YES;
    animation.repeatCount = 3;
    [imageView.layer addAnimation:animation forKey:@"animateTransform"];
    
}

+(void)showLoginViewController {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.vcType = eLogin;
    HZNavViewController *navVC = [[HZNavViewController alloc] initWithRootViewController:loginVC];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    keyWindow.rootViewController = navVC;
    [keyWindow makeKeyAndVisible];
}

+ (void)popToHomeVC:(UIViewController *)viewController {
    if (!viewController) {
        return;
    }
    
    HZNavViewController *navigationVC = (HZNavViewController *)viewController.navigationController;
    if (!navigationVC) {
        return;
    }
    
    NSArray *viewControllers = navigationVC.viewControllers;
    if (!viewControllers || viewControllers.count == 0) {
        return;
    }
    
    BOOL bPOP = NO;
    for (UIViewController *vc in viewControllers) {
        if ([vc isKindOfClass:[HomeViewController class]]) {
            [navigationVC popToViewController:vc animated:YES];
            bPOP = YES;
            break;
        }
    }
    
    if (!bPOP) {
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        [viewController.navigationController pushViewController:homeVC animated:YES];
    }
}

@end
