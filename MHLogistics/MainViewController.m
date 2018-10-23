//
//  MainViewController.m
//  HZBitApp
//
//  Created by Apple on 8/29/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "MainViewController.h"
#import "CustomTabbar.h"
#import "HZNavViewController.h"
#import "TabBarUtls.h"
#import "HomeViewController.h"
#import "AboutViewController.h"
#import "UIImage+Color.h"
#import "TaskViewController.h"



@interface MainViewController ()<UITabBarControllerDelegate> {
    BOOL bHasChange;
}
@end

@implementation MainViewController


- (instancetype)init {
    self = [super init];
    if (self) {
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        HZNavViewController *homeNavi = [[HZNavViewController alloc] initWithRootViewController:homeVC];

        TaskViewController *taskVC = [[TaskViewController alloc] init];
        HZNavViewController *taskNavi = [[HZNavViewController alloc] initWithRootViewController:taskVC];
        
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        HZNavViewController *aboutNavi = [[HZNavViewController alloc] initWithRootViewController:aboutVC];
        self.viewControllers = @[homeNavi, taskNavi, aboutNavi];
        
        [self.tabBar setBackgroundImage:[UIImage createImageWithColor:RGB(245, 245, 245)]];
        
        NSArray<UITabBarItem *> *items = self.tabBar.items;
        
        if (kScreenWidth > 320) {
            CGRect frameRect = self.tabBar.frame;
            self.tabBar.frame = CGRectMake(frameRect.origin.x, frameRect.origin.y, frameRect.size.width, frameRect.size.height + 50);
        }
        
        NSArray *tabIconArray = @[@"icon_tab_home", @"icon_tab_device", @"icon_tab_me"];
        NSArray *tabIconSelectedArray = @[@"icon_tab_home_selected", @"icon_tab_device_selected", @"icon_tab_me_selected"];
        NSArray *titleArray = @[@"mainpage", @"device", @"me"];
        for (NSInteger i = 0; i < items.count; i++) {
                UITabBarItem *barItem = items[i];
                barItem.image = [UIImage imageNamed:tabIconArray[i]];
                barItem.selectedImage = [UIImage imageNamed:tabIconSelectedArray[i]];
                barItem.title = LOCALIZEDSTRING(titleArray[i]);
            
            
                CGFloat fontSize = kScreenWidth <= 320 ? 12.0 : 16.0;
                NSDictionary *textAttrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
                [barItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];

            }
            [TabBarUtls setTabBarHeight:CGRectGetHeight(self.tabBar.frame)];
        
            bHasChange = NO;
        }
    
        [self setDelegate:self];
        return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 11.0, *)) {
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            statusBar.backgroundColor = [UIColor whiteColor];
        }
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    if (kScreenWidth > 320 && !bHasChange) {
        CGRect frameRect = self.tabBar.frame;

        self.tabBar.frame = CGRectMake(frameRect.origin.x, frameRect.origin.y - 15, frameRect.size.width, frameRect.size.height + 15);
        bHasChange = YES;
    }

}

#pragma mark
#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [[NSNotificationCenter defaultCenter] postNotificationName:kTabbarSelectChange object:nil];
}

@end
