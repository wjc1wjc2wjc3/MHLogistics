//
//  HZNavViewController.m
//  HZBitApp
//
//  Created by Apple on 8/30/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "HZNavViewController.h"
#import "UIImage+Color.h"
#import "HZBitNavigationBar.h"
#import "StatusBarUtils.h"

@interface HZNavViewController ()<HZBitNavigationBarDelegate>
@end

@implementation HZNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar removeFromSuperview];

    [self addNavigaBar];
    
}

- (void)addNavigaBar {
    CGFloat statusBarHeight = [StatusBarUtils getStatusHeight];
    CGFloat startY = 0;
    CGFloat navigationHeight = statusBarHeight;
    if (@available(iOS 11.0, *)) {
        startY = statusBarHeight;
        navigationHeight = 0;
    }
    
    HZBitNavigationBar *hzBitNavigationBar = [[HZBitNavigationBar alloc] initWithFrame:CGRectMake(0, startY, kScreenWidth, NAVIGATIONBAR_HEIGHT + navigationHeight)];
    hzBitNavigationBar.hzDelegate = self;
    [self.view addSubview:hzBitNavigationBar];
    _hzBitNavigationBar = hzBitNavigationBar;
    self.naviHeight = hzBitNavigationBar.frame.size.height;
}

- (void)hideNavigationBar {
    if (_hzBitNavigationBar) {
         [_hzBitNavigationBar setHidden:YES];
    }
}

- (void)setNaviBackgroundColor:(UIColor *)color {
    if (_hzBitNavigationBar) {
        [_hzBitNavigationBar setNaviBackgroundColor:color];
    }
}

- (void)showNavigationBar:(BOOL)bShowBack title:(NSString *)title {
    if (_hzBitNavigationBar) {
        [_hzBitNavigationBar setHidden:NO];
        [_hzBitNavigationBar setShowBackItem:bShowBack title:title];
    }
}

- (void)showSearch:(naviRightBlock)block {
    if (_hzBitNavigationBar) {
        [_hzBitNavigationBar showSearch:NO];
    }
    _rightBlock = block;
}

- (void)showRightNavi:(BOOL)bShow title:(NSString *)title  block:(naviRightBlock)block {
    if (_hzBitNavigationBar) {
        [_hzBitNavigationBar showRightNavi:bShow title:title];
    }
    _rightBlock = block;
}

- (void)setRightNaviTitle:(NSString *)title {
    if (_hzBitNavigationBar) {
        [_hzBitNavigationBar showRightNavi:YES title:title];
    }
}

- (void)hideSearch {
    if (_hzBitNavigationBar) {
        [_hzBitNavigationBar showSearch:YES];
        _rightBlock = nil;
    }
}

#pragma HZBitNavigationBarDelegate
- (void)backItem {
    if (_backBlock) {
        _backBlock();
        _backBlock = nil;
    }
    else
    {
        [self popViewControllerAnimated:YES];
    }
}

- (void)rightItem {
    if (_rightBlock) {
        _rightBlock();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
