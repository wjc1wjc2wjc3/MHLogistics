//
//  HomeCell.m
//  MHLogistics
//
//  Created by wjc on 10/27/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "HomeCell.h"

CGFloat kHCCornerRadius = 10.0;
CGFloat kHCHeaderHeight = 40.0;
CGFloat kHCHeaderImageHeight = 30.0;
CGFloat kHCSmallHeight = 21.0*0.5;
CGFloat kHCHeight = 220.0;
CGFloat kHCLeftPadding = 16.0;
CGFloat kHCRightPadding = 16.0;
CGFloat kHCWidgetHorizontalPadding = 5.0;
CGFloat kHCWidgetVerticalPadding = 20.0;
CGFloat kHCLabelPadding = 60.0;
CGFloat kHCBtnVericalPadding = 20.0;
@interface HomeCell()

@property (nonatomic, assign) CGRect baseRect;
@property (nonatomic, assign) BOOL bBottom;

@end

@implementation HomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.frame = CGRectMake(0, 0, kScreenWidth, kHCHeight);
        _bBottom = YES;
        [self initUI];
    }
    return self;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier bottom:(BOOL)bBottom{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.frame = CGRectMake(0, 0, kScreenWidth, kHCHeight);
        _bBottom = bBottom;
        [self initUI];
    }
    return self;
}

-(void)initUI {
    [self.contentView addSubview:self.baseView];
    [self.baseView addSubview:self.licensePlateLabel];
    [self.baseView addSubview:self.distanceLabel];
    [self.baseView addSubview:self.timeLabel];
    
    [self.contentView addSubview:self.clearView];
    
    [self.clearView addSubview:self.tonImageView];
    [self.clearView addSubview:self.tonTitleLabel];
    [self.clearView addSubview:self.tonLabel];

    [self.clearView addSubview:self.loadingTimeLabel];
    [self.clearView addSubview:self.loadingTimeTitleLabel];
    [self.clearView addSubview:self.loadingTimeImageView];

    [self.clearView addSubview:self.clearanceImageView];
    [self.clearView addSubview:self.clearanceTitleLabel];
    [self.clearView addSubview:self.clearanceLabel];

    [self.clearView addSubview:self.moneyImageView];
    [self.clearView addSubview:self.moneyTitleLabel];
    [self.clearView addSubview:self.moneyLabel];

    [self.clearView addSubview:self.loadingAddressImageView];
    [self.clearView addSubview:self.loadingAddressTitleLabel];
    [self.clearView addSubview:self.loadingAddressLabel];

    [self.clearView addSubview:self.dischargeImageView];
    [self.clearView addSubview:self.dischargeTitleLabel];
    [self.clearView addSubview:self.dischargeLabel];

    if (_bBottom) {
        [self.clearView addSubview:self.ignoreBtn];
        [self.clearView addSubview:self.grapOrderBtn];
    }
}

- (UIButton*)ignoreBtn {
    if (_ignoreBtn) {
        return _ignoreBtn;
    }
    
    CGRect rect = self.clearView.frame;
    CGFloat Y = self.dischargeImageView.frame.origin.y - self.dischargeImageView.frame.size.height + kHCBtnVericalPadding;
    CGFloat height = rect.size.height - Y;
    UIButton *ignoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Y, rect.size.width*0.5, height)];
    [ignoreBtn setTitle:LOCALIZEDSTRING(@"homeCellIgnor") forState:UIControlStateNormal];
    [ignoreBtn addTarget:self action:@selector(ignorAction:) forControlEvents:UIControlEventTouchUpInside];
    [ignoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _ignoreBtn = ignoreBtn;
    return _ignoreBtn;
}

- (void)ignorAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(ignoreOP:)]) {
        [_delegate ignoreOP:self.idxP];
    }
}

- (UIButton*)grapOrderBtn {
    if (_grapOrderBtn) {
        return _grapOrderBtn;
    }
    
    CGRect rect = self.clearView.frame;
    CGFloat Y = self.ignoreBtn.frame.origin.y;
    CGFloat height = rect.size.height - Y;
    UIButton *grapOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(rect.size.width*0.5, Y, rect.size.width*0.5, height)];
    [grapOrderBtn setTitle:LOCALIZEDSTRING(@"homeCellGrap") forState:UIControlStateNormal];
    [grapOrderBtn addTarget:self action:@selector(grapAction:) forControlEvents:UIControlEventTouchUpInside];
    [grapOrderBtn setTitleColor:MainColor forState:UIControlStateNormal];
    _grapOrderBtn = grapOrderBtn;
    return _grapOrderBtn;
}

- (void)grapAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(grapOrderOP:)]) {
        [_delegate grapOrderOP:self.idxP];
    }

}

- (UILabel *)tonLabel {
    if (_tonLabel) {
        return _tonLabel;
    }
    
    CGRect rect = self.tonTitleLabel.frame;
    UILabel *tonLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    tonLabel.font = [UIFont systemFontOfSize:13.0];
    _tonLabel = tonLabel;
    return _tonLabel;
}


- (UILabel *)tonTitleLabel {
    if (_tonTitleLabel) {
        return _tonTitleLabel;
    }
    
    CGRect rect = self.tonImageView.frame;
    UILabel *tonTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    tonTitleLabel.font = [UIFont systemFontOfSize:13.0];
    tonTitleLabel.text = LOCALIZEDSTRING(@"homeCellTon");
    _tonTitleLabel = tonTitleLabel;
    return _tonTitleLabel;
}

-(UIImageView *)tonImageView {
    if (_tonImageView) {
        return _tonImageView;
    }
    
    UIImageView *tonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHCLeftPadding, kHCWidgetVerticalPadding, kHCSmallHeight, kHCSmallHeight)];
    tonImageView.image = [UIImage imageNamed:@"ic_weight"];
    _tonImageView = tonImageView;
    return _tonImageView;
}


- (UILabel *)loadingTimeLabel {
    if (_loadingTimeLabel) {
        return _loadingTimeLabel;
    }
    
    CGFloat width = kHCLabelPadding + 20;
    UILabel *loadingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_baseRect.size.width - width - kHCRightPadding, kHCWidgetVerticalPadding, width, kHCSmallHeight)];
    loadingTimeLabel.font = [UIFont systemFontOfSize:13.0];
    loadingTimeLabel.textAlignment = NSTextAlignmentCenter;
    _loadingTimeLabel = loadingTimeLabel;
    return loadingTimeLabel;
}


- (UILabel *)loadingTimeTitleLabel {
    if (_loadingTimeTitleLabel) {
        return _loadingTimeTitleLabel;
    }
    
    CGRect rect = self.loadingTimeLabel.frame;
    CGFloat width = kHCLabelPadding;
    UILabel *loadingTimeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x - kHCWidgetHorizontalPadding - width, rect.origin.y, width, kHCSmallHeight)];
    loadingTimeTitleLabel.font = [UIFont systemFontOfSize:13.0];
    loadingTimeTitleLabel.text = LOCALIZEDSTRING(@"homeCellLoadingTime");
    _loadingTimeTitleLabel = loadingTimeTitleLabel;
    return _loadingTimeTitleLabel;
}

-(UIImageView *)loadingTimeImageView {
    if (_loadingTimeImageView) {
        return _loadingTimeImageView;
    }
    
    CGRect rect = self.loadingTimeTitleLabel.frame;
    UIImageView *loadingTimeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x - kHCWidgetHorizontalPadding - kHCSmallHeight, rect.origin.y, kHCSmallHeight, kHCSmallHeight)];
    loadingTimeImageView.image = [UIImage imageNamed:@"ic_loadingtime"];
    _loadingTimeImageView = loadingTimeImageView;
    return _loadingTimeImageView;
}

- (UILabel *)clearanceLabel {
    if (_clearanceLabel) {
        return _clearanceLabel;
    }
    
    CGRect rect = self.clearanceTitleLabel.frame;
    CGFloat x = rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding;
    CGFloat maxWidth = self.contentView.frame.size.width*0.5 - x;
    CGFloat width = kHCLabelPadding > maxWidth ? kHCLabelPadding : maxWidth;
    UILabel *clearanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, rect.origin.y, width, kHCSmallHeight)];
    clearanceLabel.font = [UIFont systemFontOfSize:13.0];
    _clearanceLabel = clearanceLabel;
    return _clearanceLabel;
}


- (UILabel *)clearanceTitleLabel {
    if (_clearanceTitleLabel) {
        return _clearanceTitleLabel;
    }
    
    CGRect rect = self.clearanceImageView.frame;
    UILabel *clearanceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    clearanceTitleLabel.font = [UIFont systemFontOfSize:13.0];
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
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    moneyLabel.font = [UIFont systemFontOfSize:13.0];
    _moneyLabel = moneyLabel;
    return _moneyLabel;
}


- (UILabel *)moneyTitleLabel {
    if (_moneyTitleLabel) {
        return _moneyTitleLabel;
    }
    
    CGRect rect = self.moneyImageView.frame;
    UILabel *moneyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    moneyTitleLabel.font = [UIFont systemFontOfSize:13.0];
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
    UILabel *loadingAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, rect.origin.y, _baseRect.size.width - x - kHCRightPadding, kHCSmallHeight)];
    loadingAddressLabel.font = [UIFont systemFontOfSize:13.0];
    _loadingAddressLabel = loadingAddressLabel;
    return _loadingAddressLabel;
}


- (UILabel *)loadingAddressTitleLabel {
    if (_loadingAddressTitleLabel) {
        return _loadingAddressTitleLabel;
    }
    
    CGRect rect = self.loadingAddressImageView.frame;
    UILabel *loadingAddressTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    loadingAddressTitleLabel.font = [UIFont systemFontOfSize:13.0];
    loadingAddressTitleLabel.text = LOCALIZEDSTRING(@"homeCellLoadingAddress");
    _loadingAddressTitleLabel = loadingAddressTitleLabel;
    return _loadingAddressTitleLabel;
}

-(UIImageView *)loadingAddressImageView {
    if (_loadingAddressImageView) {
        return _loadingAddressImageView;
    }
    
    CGRect rect = self.clearanceImageView.frame;
    UIImageView *loadingAddressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHCLeftPadding, rect.origin.y + rect.size.height + kHCWidgetVerticalPadding, kHCSmallHeight, kHCSmallHeight)];
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
    UILabel *dischargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, rect.origin.y, _baseRect.size.width - x -kHCRightPadding, kHCSmallHeight)];
    dischargeLabel.font = [UIFont systemFontOfSize:13.0];
    _dischargeLabel = dischargeLabel;
    return _dischargeLabel;
}

- (void)setIgnoreBtnTitle:(NSString *)title  {
    if (_ignoreBtn) {
        [_ignoreBtn setTitle:title forState:UIControlStateNormal];
    }
}

- (void)setGrapOrderBtnTitle:(NSString *)title {
    if (_grapOrderBtn) {
        [_grapOrderBtn setTitle:title forState:UIControlStateNormal];
    }
}

- (UILabel *)dischargeTitleLabel {
    if (_dischargeTitleLabel) {
        return _dischargeTitleLabel;
    }
    
    CGRect rect = self.dischargeImageView.frame;
    UILabel *dischargeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + kHCWidgetHorizontalPadding, rect.origin.y, kHCLabelPadding, kHCSmallHeight)];
    dischargeTitleLabel.font = [UIFont systemFontOfSize:13.0];
    dischargeTitleLabel.text = LOCALIZEDSTRING(@"homeCellDischargeAddress");
    _dischargeTitleLabel = dischargeTitleLabel;
    return _dischargeTitleLabel;
}

-(UIImageView *)dischargeImageView {
    if (_dischargeImageView) {
        return _dischargeImageView;
    }
    
    CGRect rect = self.loadingAddressImageView.frame;
    UIImageView *dischargeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHCLeftPadding, rect.origin.y + rect.size.height + kHCWidgetVerticalPadding, kHCSmallHeight, kHCSmallHeight)];
    dischargeImageView.image = [UIImage imageNamed:@"ic_discharge_site"];
    _dischargeImageView = dischargeImageView;
    return _dischargeImageView;
}


- (UILabel *)timeLabel {
    if (_timeLabel) {
        return _timeLabel;
    }
    
    CGRect rect = self.distanceLabel.frame;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x - 100 - 5, 0, 100, kHCHeaderHeight)];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.font = [UIFont systemFontOfSize:13.0];
    _timeLabel = timeLabel;
    
    return timeLabel;
}


- (UILabel *)distanceLabel {
    if (_distanceLabel) {
        return _distanceLabel;
    }
    
    CGRect rect = self.baseView.frame;
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width - 40-20, 0, 40, kHCHeaderHeight)];
    distanceLabel.textAlignment = NSTextAlignmentRight;
    distanceLabel.textColor = [UIColor blackColor];
    distanceLabel.font = [UIFont systemFontOfSize:13.0];
    _distanceLabel = distanceLabel;
    
    return _distanceLabel;
}

- (UILabel *)licensePlateLabel {
    if (_licensePlateLabel) {
        return _licensePlateLabel;
    }
    
    UILabel *licensePlateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, kHCHeaderHeight)];
    licensePlateLabel.textColor = [UIColor blackColor];
    licensePlateLabel.font = [UIFont systemFontOfSize:17.0];
    _licensePlateLabel = licensePlateLabel;
    
    return _licensePlateLabel;
}

- (NSMutableArray *)imageViewArray {
    if (_imageViewArray) {
        return _imageViewArray;
    }
    
    CGRect rect = self.licensePlateLabel.frame;
    _imageViewArray =[NSMutableArray arrayWithCapacity:3];
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width+(kHCHeaderImageHeight+5)*i, rect.origin.y, kHCHeaderImageHeight, kHCHeaderImageHeight)];
        imageView.center = CGPointMake(imageView.center.x, self.licensePlateLabel.center.y);
        imageView.contentMode = UIViewContentModeCenter;
        [self.baseView addSubview:imageView];
        [_imageViewArray addObject:imageView];
    }
    
    return _imageViewArray;
    
}

- (UIView *)baseView {
    if (_baseView) {
        return _baseView;
    }
    
    CGRect rect = self.contentView.frame;
    _baseRect = CGRectMake(5, 5, rect.size.width-5*2, rect.size.height-5*2);
    UIView *baseView = [[UIView alloc] initWithFrame:_baseRect];
    baseView.backgroundColor = HomeGrayColor;
    baseView.layer.cornerRadius = kHCCornerRadius;
    baseView.layer.masksToBounds = YES;
    baseView.layer.borderWidth =1.0;
    baseView.layer.borderColor = GrayColor.CGColor;
    _baseView = baseView;
    return baseView;
}

- (UIView *)clearView {
    if (_clearView) {
        return _clearView;
    }
    
    CGRect lpRect = self.licensePlateLabel.frame;
    CGRect baseRect = CGRectMake(5 + 1, lpRect.origin.y + lpRect.size.height+5 + 1, kScreenWidth-5*2- 1*2, kHCHeight-lpRect.size.height-5-1*2);
    UIView *clearView = [[UIView alloc] initWithFrame:baseRect];
    clearView.backgroundColor = [UIColor whiteColor];
    _clearView = clearView;
    return clearView;
}

@end
