//
//  HomeCell.h
//  MHLogistics
//
//  Created by wjc on 10/27/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>


extern CGFloat kHCCornerRadius;
extern CGFloat kHCHeaderHeight;
extern CGFloat kHCHeaderImageHeight;
extern CGFloat kHCSmallHeight;
extern CGFloat kHCHeight;
extern CGFloat kHCLeftPadding;
extern CGFloat kHCRightPadding;
extern CGFloat kHCWidgetHorizontalPadding;
extern CGFloat kHCWidgetVerticalPadding;
extern CGFloat kHCLabelPadding;
extern CGFloat kHCBtnVericalPadding;

@protocol HomeDelegate<NSObject>

@optional
- (void)ignoreOP:(NSIndexPath*)idxP;
- (void)grapOrderOP:(NSIndexPath *)idxP;

@end

extern CGFloat kHCHeight;

@interface HomeCell : UITableViewCell

@property (nonatomic,weak) id<HomeDelegate> delegate;
@property (nonatomic,weak) NSIndexPath *idxP;

@property (nonatomic, weak) UIView *baseView;

@property (nonatomic, weak) UILabel *licensePlateLabel;
@property (nonatomic, weak) UILabel *distanceLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, strong) NSMutableArray *imageViewArray;

@property (nonatomic, weak) UIView *clearView;
//吨位
@property (nonatomic, weak) UIImageView *tonImageView;
@property (nonatomic, weak) UILabel *tonTitleLabel;
@property (nonatomic, weak) UILabel *tonLabel;
//装货时间
@property (nonatomic, weak) UIImageView *loadingTimeImageView;
@property (nonatomic, weak) UILabel *loadingTimeTitleLabel;
@property (nonatomic, weak) UILabel *loadingTimeLabel;
//通关口岸
@property (nonatomic, weak) UIImageView *clearanceImageView;
@property (nonatomic, weak) UILabel *clearanceTitleLabel;
@property (nonatomic, weak) UILabel *clearanceLabel;
//金额
@property (nonatomic, weak) UIImageView *moneyImageView;
@property (nonatomic, weak) UILabel *moneyTitleLabel;
@property (nonatomic, weak) UILabel *moneyLabel;
//装货地址
@property (nonatomic, weak) UIImageView *loadingAddressImageView;
@property (nonatomic, weak) UILabel *loadingAddressTitleLabel;
@property (nonatomic, weak) UILabel *loadingAddressLabel;
//卸货地址
@property (nonatomic, weak) UIImageView *dischargeImageView;
@property (nonatomic, weak) UILabel *dischargeTitleLabel;
@property (nonatomic, weak) UILabel *dischargeLabel;


@property (nonatomic, weak) UIButton *ignoreBtn;
@property (nonatomic, weak) UIButton *grapOrderBtn;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier bottom:(BOOL)bBottom;
- (void)setIgnoreBtnTitle:(NSString *_Nullable)title;
- (void)setGrapOrderBtnTitle:(NSString *_Nullable)title;
@end
