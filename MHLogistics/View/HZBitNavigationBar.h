//
//  HZBitNavigationBar.h
//  HZBitApp
//
//  Created by Apple on 9/2/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HZBitNavigationBarDelegate <NSObject>

@optional
- (void)backItem;
- (void)rightItem;
@end

@interface HZBitNavigationBar : UINavigationBar<UINavigationBarDelegate>

@property (nonatomic, strong) UINavigationItem *navigationItem;
@property (nonatomic, weak) id<HZBitNavigationBarDelegate> hzDelegate;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setShowBackItem:(BOOL)bShow title:(NSString *)title;

- (void)setNaviBackgroundColor:(UIColor *)color;

- (void)showSearch:(BOOL)bShow;

- (void)showRightNavi:(BOOL)bShow title:(NSString *)title;
@end
