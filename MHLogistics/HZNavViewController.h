//
//  HZNavViewController.h
//  HZBitApp
//
//  Created by Apple on 8/30/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZBitNavigationBar.h"

typedef void(^naviBackBlock)(void);
typedef void(^naviRightBlock)(void);

@interface HZNavViewController : UINavigationController

@property (nonatomic, strong)HZBitNavigationBar *hzBitNavigationBar;

@property (nonatomic, copy)naviBackBlock backBlock;
@property (nonatomic, copy)naviRightBlock rightBlock;
@property (nonatomic, assign)CGFloat naviHeight;

- (void)hideNavigationBar;
- (void)showNavigationBar:(BOOL)bShowBack title:(NSString *)title;
- (void)setNaviBackgroundColor:(UIColor *)color;
- (void)showSearch:(naviRightBlock)block;
- (void)showRightNavi:(BOOL)bShow title:(NSString *)title  block:(naviRightBlock)block;
- (void)setRightNaviTitle:(NSString *)title;
- (void)hidebSearch;
@end
