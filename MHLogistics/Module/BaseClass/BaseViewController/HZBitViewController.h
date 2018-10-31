//
//  HZBitViewController.h
//  HZBitSmartLock
//
//  Created by Apple on 10/20/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXBitViewModel.h"
#import "HZNavViewController.h"
#import "DeviceUtils.h"
#import <MJRefresh/MJRefresh.h>

typedef void(^headerRefreshBlock)(void);

@interface HZBitViewController : UIViewController

@property (nonatomic, copy) NSString *naviTitle;
@property (nonatomic, strong, readonly) MXBitViewModel *viewModel;

- (instancetype)init;
- (HZBitViewController *)initWithViewModel:(id)viewModel;
- (void)showIndicator:(BOOL)bHiddenOther;
- (void)hiddenIndicator:(BOOL)bHiddenOther;

- (void)showSearch:(naviRightBlock)block;
- (void)hideSearch;
- (void)hideNaviBar;
- (void)showNaviBar:(NSString *)title;
- (void)showNaviBar:(BOOL)bShowBack title:(NSString *)title;
- (void)setNaviBarBackgroundColor:(UIColor *)color;
- (void)setNavibarBlock:(naviBackBlock)block;
- (void)showRightNavi:(BOOL)bShow title:(NSString *)title block:(naviRightBlock)block;
- (void)setRightNaviTitle:(NSString *)title;
- (void)setExtraCellLineHidden: (UITableView *)tableView;
- (CGFloat)getNaviHeight;

- (void)setSubViewsOffset:(BOOL)decrease;
- (void)setSubViewOffset:(UIView *)offsetView decreaseHeight:(BOOL)decrease;

- (MJRefreshHeader *)createFreshHeader:(headerRefreshBlock)block;
@end
