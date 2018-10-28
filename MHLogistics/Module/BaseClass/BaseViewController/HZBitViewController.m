//
//  HZBitViewController.m
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "HZBitViewController.h"

NSInteger const indicatorTag = 1000;

@interface HZBitViewController ()

@property (nonatomic, strong, readwrite) HZBitViewModel *viewModel;
@property (nonatomic, weak)UIActivityIndicatorView *indicatorView;
@property (nonatomic, weak)UIView *indicatorViewBg;
@end

@implementation HZBitViewController

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    
    return self;
}

- (HZBitViewController *)initWithViewModel:(id)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self initView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)initView {
    DLog(@" %f, %f", kScreenWidth, kScreenHeight);
    
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setSubViewsOffset:(BOOL)decrease {
    
    if (![DeviceUtils isiPhoneX]) {
        return;
    }
    
    NSArray *views = self.view.subviews;
    [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *subView = (UIView *)obj;
        CGRect rect = subView.frame;
        CGFloat offHeight = decrease ? rect.size.height - iPhoneX_Bang_Height : rect.size.height;
        subView.frame = CGRectMake(rect.origin.x, rect.origin.y + iPhoneX_Bang_Height, rect.size.width, offHeight);
    }];
}

- (void)setSubViewOffset:(UIView *)offsetView decreaseHeight:(BOOL)decrease {
    
    if (![DeviceUtils isiPhoneX]) {
        return;
    }
    
    if (!offsetView) {
        return;
    }
    
    CGFloat bangHeight = iPhoneX_Bang_Height * 2;
    CGRect rect = offsetView.frame;
    CGFloat offHeight = decrease ? rect.size.height - bangHeight : rect.size.height;
    offsetView.frame = CGRectMake(rect.origin.x, rect.origin.y + bangHeight, rect.size.width, offHeight);
}


-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)showIndicator:(BOOL)bHiddenOther {
    if (!_indicatorView) {
        
        UIWindow *windows = [[UIApplication sharedApplication] keyWindow];
        UIViewController *rootVC = windows.rootViewController;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        view.tag = indicatorTag;
        [view setBackgroundColor:ARGB(0, 0, 0, 0.5)];
        [rootVC.view addSubview:view];
        _indicatorViewBg = view;
        
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
         indicatorView.frame = CGRectMake(0, 0, 30, 30);
        [indicatorView setCenter:CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5)];
        [indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [_indicatorViewBg addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    
    if ([_indicatorView isAnimating]) {
        return;
    }
    

    if (bHiddenOther) {
        NSArray *views = [self.view subviews];
        for (UIView *view in views) {
            NSInteger tag = view.tag;
            if (tag != indicatorTag) {
                [view setHidden:YES];
            }
        }
    }
    
    [_indicatorView setHidden:NO];
    [_indicatorView startAnimating];
    
}

- (void)hiddenIndicator:(BOOL)bHiddenOther {
    UIWindow *windows = [[UIApplication sharedApplication] keyWindow];
    UIViewController *rootVC = windows.rootViewController;
    NSArray *views = [rootVC.view subviews];
    for (UIView *view in views) {
        if (view.tag == indicatorTag) {
            [_indicatorView stopAnimating];
            [_indicatorView removeFromSuperview];
            _indicatorView = nil;
            
            [_indicatorViewBg removeFromSuperview];
            _indicatorViewBg = nil;
        }
        else
        {
            if (bHiddenOther) {
                [view setHidden:NO];
            }
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)showSearch:(naviRightBlock)block {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(HZNavViewController *)naviVC showSearch:block];
    }
}

- (void)hideSearch {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(HZNavViewController *)naviVC hideSearch];
    }
}

- (void)hideNaviBar {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(HZNavViewController *)naviVC hideNavigationBar];
    }
}

- (void)showNaviBar:(NSString *)title {
    [self showNaviBar:YES title:title];
}

- (void)showNaviBar:(BOOL)bShowBack title:(NSString *)title {
    self.naviTitle = title;
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(HZNavViewController *)naviVC showNavigationBar:bShowBack title:title];
    }
}

- (CGFloat)getNaviHeight {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        return [(HZNavViewController *)naviVC naviHeight];
    }
    return 0;
}

- (void)setNaviBarBackgroundColor:(UIColor *)color {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(HZNavViewController *)naviVC setNaviBackgroundColor:color];
    }
}

- (void)setNavibarBlock:(naviBackBlock)block {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(HZNavViewController *)naviVC setBackBlock:block];
    }
}

- (void)showRightNavi:(BOOL)bShow title:(NSString *)title block:(naviRightBlock)block {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(HZNavViewController *)naviVC showRightNavi:bShow title:title block:block];
    }
}

- (void)setRightNaviTitle:(NSString *)title {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(HZNavViewController *)naviVC setRightNaviTitle:title];
    }
}

- (MJRefreshHeader *)createFreshHeader:(headerRefreshBlock)block {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];

    [header setTitle:LOCALIZEDSTRING(@"refreshStateIdle") forState:MJRefreshStateIdle];
    [header setTitle:LOCALIZEDSTRING(@"refreshStatePulling") forState:MJRefreshStatePulling];
    [header setTitle:LOCALIZEDSTRING(@"refreshStateRefreshing") forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont systemFontOfSize:15.0];
    header.stateLabel.textColor = [UIColor grayColor];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14.0];
    header.lastUpdatedTimeLabel.textColor = [UIColor grayColor];
    return header;
}

@end
