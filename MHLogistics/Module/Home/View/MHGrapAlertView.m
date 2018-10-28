//
//  MHGrapAlertView.m
//  MHLogistics
//
//  Created by wjc on 10/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MHGrapAlertView.h"
#import "UIImage+Color.h"
#import "HomeCell.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ViewScaleIphone5Value    ([UIScreen mainScreen].bounds.size.width/320.0f)

CGFloat kGrapViewFont = 12.0f;

@interface MHGrapAlertView ()<UIGestureRecognizerDelegate>


@property (nonatomic,strong) UIWindow       *alertWindow;
@property (nonatomic,strong) UIView         *backgroundView;
@property (nonatomic,strong) UIView         *animateView;
@property (nonatomic,assign) CGRect         bgRect;
@property (nonatomic,strong) UIButton       *grapButton;
@property (nonatomic,strong) HomeData       *data;
@property (nonatomic,copy) MHGrapBlock      grapBlock;

@property (nonatomic,weak) UILabel       *lpLabel;
@property (nonatomic,weak) UILabel       *timeLabel;
@property (nonatomic,weak) UILabel       *distanceLabel;
@property (nonatomic,strong) NSMutableArray *carTypeArray;
//吨位
@property (nonatomic, assign) CGFloat tonImageViewY;
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

@end

@implementation MHGrapAlertView

+ (instancetype)showGrapWithData:(HomeData *)data grapBlock:(MHGrapBlock)grapBlock {
    MHGrapAlertView *alertView = [[self alloc] initGrapWithData:data grapBlock:grapBlock];
    return alertView;
}

- (instancetype)initGrapWithData:(HomeData *)data
                          grapBlock:(MHGrapBlock)grapBlock
{
    self = [super init];
    
    if (self) {
        
        _data = data;
        
        [self.alertWindow addSubview:self.view];
        [self.alertWindow addSubview:self.animateView];

        self.grapBlock = grapBlock;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeViewAction)];
        tapGesture.delegate = self;
        [self.view addGestureRecognizer:tapGesture];
        
    }
    return self;
}

- (void)closeViewAction{
    
    [UIView animateWithDuration:.2 animations:^{
        self.animateView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.08
                         animations:^{
                             self.animateView.transform = CGAffineTransformMakeScale(0.25, 0.25);
                         }completion:^(BOOL finish){
                             [self.alertWindow removeFromSuperview];
                             self.alertWindow.rootViewController = nil;
                             self.alertWindow = nil;
                             
                         }];
    }];
    
}

- (UIWindow *)alertWindow
{
    if (!_alertWindow) {
        _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _alertWindow.windowLevel = UIWindowLevelAlert;
        _alertWindow.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        [_alertWindow makeKeyAndVisible];
        _alertWindow.rootViewController = self;
    }
    return _alertWindow;
}

- (UIView *)animateView {
    if (_animateView) {
        return _animateView;
    }
    
    CGFloat width = ScreenWidth - 50 * ViewScaleIphone5Value + 100*0.5;
    UIView *animateView = [[UIView alloc] initWithFrame:CGRectMake(25 * ViewScaleIphone5Value, (ScreenHeight - width)*0.5, width, width)];
    
    [animateView addSubview:self.backgroundView];
    [animateView addSubview:self.grapButton];
    animateView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    _animateView = animateView;
    
    [UIView animateWithDuration:.3
                     animations:^{
                         animateView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                     }completion:^(BOOL finish){
                         [UIView animateWithDuration:.3
                                          animations:^{
                                              animateView.transform = CGAffineTransformMakeScale(0.95, 0.95);
                                          }completion:^(BOOL finish){
                                              [UIView animateWithDuration:.3
                                                               animations:^{
                                                                   animateView.transform = CGAffineTransformMakeScale(1, 1);
                                                               }];
                                          }];
                     }];
    
    return animateView;
}

- (UIView *)backgroundView
{
    if (_backgroundView) {
        return _backgroundView;
    }
    
    CGFloat width = ScreenWidth - 50 * ViewScaleIphone5Value;
    _bgRect = CGRectMake(0, 0, width, width);
    UIView *backgroundView = [[UIView alloc] initWithFrame:_bgRect];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.cornerRadius = width*0.5;
    backgroundView.layer.masksToBounds = YES;
    _backgroundView = backgroundView;


    [backgroundView addSubview:self.lpLabel];
    [backgroundView addSubview:self.distanceLabel];
    [backgroundView addSubview:self.timeLabel];
    CGRect lpRect = self.distanceLabel.frame;
    NSArray *array = @[@"ic_deal_general", @"ic_deal_ordinary", @"ic_deal_outday", @"ic_export", @"ic_import",@"ic_urgent"];
    NSInteger dataCount = self.data.typeArray.count;
    CGFloat imageStartX = (width - (kHCSmallHeight*2+10) * dataCount)*0.5;
    _carTypeArray = [NSMutableArray arrayWithCapacity:dataCount];
    for (NSUInteger i = 0; i < dataCount; i++) {
        NSNumber *rdxNum = self.data.typeArray[i];
        NSInteger idx = rdxNum.integerValue;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:array[idx]]];
        imageView.frame = CGRectMake(imageStartX + (kHCSmallHeight*2+10)*i, lpRect.origin.y +lpRect.size.height + 10, kHCSmallHeight*2, kHCSmallHeight*2);
        [backgroundView addSubview:imageView];
        [_carTypeArray addObject:imageView];
        if (_tonImageViewY == 0) {
            _tonImageViewY = imageView.frame.origin.y + imageView.frame.size.height + 5;
        }

    }
    
    [backgroundView addSubview:self.tonImageView];
    [backgroundView addSubview:self.tonTitleLabel];
    [backgroundView addSubview:self.tonLabel];

    [backgroundView addSubview:self.loadingTimeImageView];
    [backgroundView addSubview:self.loadingTimeTitleLabel];
    [backgroundView addSubview:self.loadingTimeLabel];

    [backgroundView addSubview:self.clearanceImageView];
    [backgroundView addSubview:self.clearanceTitleLabel];
    [backgroundView addSubview:self.clearanceLabel];

    [backgroundView addSubview:self.moneyImageView];
    [backgroundView addSubview:self.moneyTitleLabel];
    [backgroundView addSubview:self.moneyLabel];

    [backgroundView addSubview:self.loadingAddressImageView];
    [backgroundView addSubview:self.loadingAddressTitleLabel];
    [backgroundView addSubview:self.loadingAddressLabel];

    [backgroundView addSubview:self.dischargeImageView];
    [backgroundView addSubview:self.dischargeTitleLabel];
    [backgroundView addSubview:self.dischargeLabel];
    


    return _backgroundView;
}

- (UILabel *)timeLabel {
    if (_timeLabel) {
        return _timeLabel;
    }
    
    CGRect rect = _bgRect;
    CGFloat Y = self.distanceLabel.frame.origin.y;
    CGFloat width = 80;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width*0.5 - width - 5, Y, width, kHCHeaderHeight-10)];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.text = self.data.timeNow;
    timeLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    _timeLabel = timeLabel;
    
    return timeLabel;
}

- (UILabel *)distanceLabel {
    if (_distanceLabel) {
        return _distanceLabel;
    }
    
    CGRect rect = _bgRect;
    CGFloat Y = self.lpLabel.frame.origin.y + self.lpLabel.frame.size.height;
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width*0.5+5, Y, 40, kHCHeaderHeight-10)];
    distanceLabel.textAlignment = NSTextAlignmentLeft;
    distanceLabel.textColor = [UIColor blackColor];
    distanceLabel.text = self.data.distance;
    distanceLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    _distanceLabel = distanceLabel;
    
    return _distanceLabel;
}

- (UILabel *)lpLabel {
    if (_lpLabel) {
        return _lpLabel;
    }
    
    CGRect rect = CGRectMake(_bgRect.size.width*0.5-100*0.5, 30, 100, kHCHeaderHeight*0.5);
    UILabel *lpLabel = [[UILabel alloc] initWithFrame:rect];
    lpLabel.textColor = [UIColor blackColor];
    CGPoint point = lpLabel.center;
    lpLabel.center = CGPointMake(_bgRect.size.width*0.5, point.y);
    lpLabel.textAlignment = NSTextAlignmentCenter;
    lpLabel.text = self.data.licenseP;
    lpLabel.font = [UIFont systemFontOfSize:17.0];
    _lpLabel = lpLabel;
    
    return lpLabel;
}

- (UILabel *)tonLabel {
    if (_tonLabel) {
        return _tonLabel;
    }
    
    CGRect rect = self.tonTitleLabel.frame;
    UILabel *tonLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    tonLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    tonLabel.text = self.data.ton;
    _tonLabel = tonLabel;
    return _tonLabel;
}


- (UILabel *)tonTitleLabel {
    if (_tonTitleLabel) {
        return _tonTitleLabel;
    }
    
    CGRect rect = self.tonImageView.frame;
    UILabel *tonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    tonTitleLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    tonTitleLabel.text = LOCALIZEDSTRING(@"homeCellTon");
    _tonTitleLabel = tonTitleLabel;
    return _tonTitleLabel;
}

-(UIImageView *)tonImageView {
    if (_tonImageView) {
        return _tonImageView;
    }
    
    UIImageView *tonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHCLeftPadding, _tonImageViewY, kHCSmallHeight, kHCSmallHeight)];
    tonImageView.image = [UIImage imageNamed:@"ic_weight"];
    _tonImageView = tonImageView;
    return _tonImageView;
}


- (UILabel *)loadingTimeLabel {
    if (_loadingTimeLabel) {
        return _loadingTimeLabel;
    }

    CGRect rect = _loadingTimeTitleLabel.frame;
    CGFloat x = rect.origin.x + rect.size.width + 5;
    UILabel *loadingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width, _tonImageViewY, _bgRect.size.width - x, kHCSmallHeight)];
    loadingTimeLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    loadingTimeLabel.textAlignment = NSTextAlignmentCenter;
    loadingTimeLabel.text = self.data.loading;
    _loadingTimeLabel = loadingTimeLabel;
    return loadingTimeLabel;
}


- (UILabel *)loadingTimeTitleLabel {
    if (_loadingTimeTitleLabel) {
        return _loadingTimeTitleLabel;
    }
    
    CGRect rect = self.loadingTimeImageView.frame;
    CGFloat width = kHCLabelPadding;
    UILabel *loadingTimeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + 5, rect.origin.y, width, kHCSmallHeight)];
    loadingTimeTitleLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    loadingTimeTitleLabel.text = LOCALIZEDSTRING(@"homeCellLoadingTime");
    _loadingTimeTitleLabel = loadingTimeTitleLabel;
    return _loadingTimeTitleLabel;
}

-(UIImageView *)loadingTimeImageView {
    if (_loadingTimeImageView) {
        return _loadingTimeImageView;
    }
    
    CGRect rect = _bgRect;
    UIImageView *loadingTimeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.size.width*0.5 + kHCWidgetHorizontalPadding +10, _tonImageViewY, kHCSmallHeight, kHCSmallHeight)];
    loadingTimeImageView.image = [UIImage imageNamed:@"ic_loadingtime"];
    _loadingTimeImageView = loadingTimeImageView;
    return _loadingTimeImageView;
}

- (UILabel *)clearanceLabel {
    if (_clearanceLabel) {
        return _clearanceLabel;
    }
    
    CGRect rect = self.clearanceTitleLabel.frame;
    CGFloat x = rect.origin.x + rect.size.width;
    UILabel *clearanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, rect.origin.y, kHCLabelPadding + 40, kHCSmallHeight)];
    clearanceLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    clearanceLabel.text = self.data.clearance;
    _clearanceLabel = clearanceLabel;
    return _clearanceLabel;
}


- (UILabel *)clearanceTitleLabel {
    if (_clearanceTitleLabel) {
        return _clearanceTitleLabel;
    }
    
    CGRect rect = self.clearanceImageView.frame;
    UILabel *clearanceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    clearanceTitleLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    clearanceTitleLabel.text = LOCALIZEDSTRING(@"homeCellClearance");
    _clearanceTitleLabel = clearanceTitleLabel;
    return _clearanceTitleLabel;
}

-(UIImageView *)clearanceImageView {
    if (_clearanceImageView) {
        return _clearanceImageView;
    }
    
    CGRect rect = self.tonImageView.frame;
    UIImageView *clearanceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHCLeftPadding, rect.origin.y + rect.size.height + kHCWidgetVerticalPadding, kHCSmallHeight, kHCSmallHeight)];
    clearanceImageView.image = [UIImage imageNamed:@"ic_import_port"];
    _clearanceImageView = clearanceImageView;
    return _clearanceImageView;
}


- (UILabel *)moneyLabel {
    if (_moneyLabel) {
        return _moneyLabel;
    }
    
    CGRect rect = self.moneyTitleLabel.frame;
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width +5, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    moneyLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    moneyLabel.text = self.data.money;
    _moneyLabel = moneyLabel;
    return _moneyLabel;
}


- (UILabel *)moneyTitleLabel {
    if (_moneyTitleLabel) {
        return _moneyTitleLabel;
    }
    
    CGRect rect = self.moneyImageView.frame;
    UILabel *moneyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + + 5, rect.origin.y, kHCLabelPadding*0.8, kHCSmallHeight)];
    moneyTitleLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    moneyTitleLabel.text = LOCALIZEDSTRING(@"homeCellMoney");
    _moneyTitleLabel = moneyTitleLabel;
    return _moneyTitleLabel;
}

-(UIImageView *)moneyImageView {
    if (_moneyImageView) {
        return _moneyImageView;
    }
    
    CGRect rect = self.loadingTimeImageView.frame;
    UIImageView *moneyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x, self.clearanceImageView.frame.origin.y, kHCSmallHeight, kHCSmallHeight)];
    moneyImageView.image = [UIImage imageNamed:@"ic_amount"];
    _moneyImageView = moneyImageView;
    return _moneyImageView;
}

- (UILabel *)loadingAddressLabel {
    if (_loadingAddressLabel) {
        return _loadingAddressLabel;
    }
    
    CGRect rect = self.loadingAddressTitleLabel.frame;
    CGFloat x = rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding;
    CGRect bgRect = _bgRect;
    UILabel *loadingAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, rect.origin.y, bgRect.size.width - x - kHCRightPadding, kHCSmallHeight)];
    loadingAddressLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    loadingAddressLabel.text = self.data.loadingAddress;
    _loadingAddressLabel = loadingAddressLabel;
    return _loadingAddressLabel;
}


- (UILabel *)loadingAddressTitleLabel {
    if (_loadingAddressTitleLabel) {
        return _loadingAddressTitleLabel;
    }
    
    CGRect rect = self.loadingAddressImageView.frame;
    UILabel *loadingAddressTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    loadingAddressTitleLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    loadingAddressTitleLabel.text = LOCALIZEDSTRING(@"homeCellLoadingAddress");
    _loadingAddressTitleLabel = loadingAddressTitleLabel;
    return _loadingAddressTitleLabel;
}

-(UIImageView *)loadingAddressImageView {
    if (_loadingAddressImageView) {
        return _loadingAddressImageView;
    }
    
    CGRect rect = self.clearanceImageView.frame;
    UIImageView *loadingAddressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHCLeftPadding*3, rect.origin.y + rect.size.height + kHCWidgetVerticalPadding, kHCSmallHeight, kHCSmallHeight)];
    loadingAddressImageView.image = [UIImage imageNamed:@"ic_loadingtime"];
    _loadingAddressImageView = loadingAddressImageView;
    return _loadingAddressImageView;
}

- (UILabel *)dischargeLabel {
    if (_dischargeLabel) {
        return _dischargeLabel;
    }
    
    CGRect rect = self.dischargeTitleLabel.frame;
    CGFloat x = rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding;
    CGRect bgRect = _bgRect;
    UILabel *dischargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, rect.origin.y, bgRect.size.width - x -kHCRightPadding, kHCSmallHeight)];
    dischargeLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    dischargeLabel.text = self.data.unloadAddress;
    _dischargeLabel = dischargeLabel;
    return _dischargeLabel;
}


- (UILabel *)dischargeTitleLabel {
    if (_dischargeTitleLabel) {
        return _dischargeTitleLabel;
    }
    
    CGRect rect = self.dischargeImageView.frame;
    UILabel *dischargeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    dischargeTitleLabel.font = [UIFont systemFontOfSize:kGrapViewFont];
    dischargeTitleLabel.text = LOCALIZEDSTRING(@"homeCellDischargeAddress");
    _dischargeTitleLabel = dischargeTitleLabel;
    return _dischargeTitleLabel;
}

-(UIImageView *)dischargeImageView {
    if (_dischargeImageView) {
        return _dischargeImageView;
    }
    
    CGRect rect = self.loadingAddressImageView.frame;
    UIImageView *dischargeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_loadingAddressImageView.frame.origin.x, rect.origin.y + rect.size.height + kHCWidgetVerticalPadding, kHCSmallHeight, kHCSmallHeight)];
    dischargeImageView.image = [UIImage imageNamed:@"ic_discharge_site"];
    _dischargeImageView = dischargeImageView;
    return _dischargeImageView;
}

- (UIButton *)grapButton {
    if (_grapButton) {
        return _grapButton;
    }
    
    CGFloat width = 100;
    CGRect rect = CGRectMake((_bgRect.size.width-width)*0.5, /*_bgRect.origin.y + */_bgRect.size.height -width*0.5, width, width);
    UIButton *grapButton = [[UIButton alloc] initWithFrame:rect];
    [grapButton addTarget:self action:@selector(grapAction:) forControlEvents:UIControlEventTouchUpInside];
    [grapButton setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [grapButton setTitle:LOCALIZEDSTRING(@"homeCellGrap") forState:UIControlStateNormal];
    [grapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    grapButton.layer.cornerRadius = width*0.5;
    grapButton.layer.masksToBounds = YES;
    _grapButton = grapButton;
    return grapButton;
}

- (void)grapAction:(UIButton *)button {
    if (self.grapBlock) {
        self.grapBlock();
    }
}

@end
