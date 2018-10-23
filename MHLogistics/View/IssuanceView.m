//
//  IssuanceView.m
//  HZBitApp
//
//  Created by Apple on 9/1/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "IssuanceView.h"
#import "UIImage+Color.h"

@interface IssuanceView ()

@property (nonatomic, weak) UILabel *issuanceLabel;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIDatePicker *datePicker;
@property (nonatomic, weak) UIButton *cancelBtn;
@property (nonatomic, weak) UIButton *okBtn;

@end

@implementation IssuanceView

- (instancetype)initIssuanceView:(UIDatePickerMode)mode startDate:(BOOL)bStart
{
    if (self = [super init]) {
        [MMPopupWindow sharedWindow].touchWildToHide = YES;
        self.type = MMPopupTypeCustom;
        
        UIScreen *mainScreen = [UIScreen mainScreen];
        CGRect bounds = mainScreen.bounds;
        CGFloat width = bounds.size.width;
        CGFloat tableViewHeight = 300;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(tableViewHeight);
            make.width.mas_equalTo(width - 40);
        }];
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *issuanceLabel = [[UILabel alloc] init];
        [issuanceLabel setTextColor:HZ_BIT_BLUE];
        NSString *title = bStart ? LOCALIZEDSTRING(@"startDateTitle") : LOCALIZEDSTRING(@"endDateTitle");
        [issuanceLabel setText:title];
        [self addSubview:issuanceLabel];
        _issuanceLabel = issuanceLabel;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage createImageWithColor:HZ_BIT_BLUE]];
        [self addSubview:imageView];
        _imageView = imageView;
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        NSLocale *cnLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        datePicker.locale = cnLocale;
        if (_minimumDate) {
            datePicker.minimumDate = _minimumDate;
        }
        else
        {
            datePicker.minimumDate = [NSDate date];
        }
        
        if (_maximumDate) {
            datePicker.maximumDate = _maximumDate;
        }

        datePicker.datePickerMode = mode;//UIDatePickerModeDateAndTime;
        if (kScreenWidth <= 320) {
            datePicker.datePickerMode = UIDatePickerModeDate;
        }
        
        [self addSubview:datePicker];
        _datePicker = datePicker;
        
        UIButton *cancelBtn = [[UIButton alloc] init];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:LOCALIZEDSTRING(@"cancel") forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn.layer setBorderWidth:1.0];
        [cancelBtn.layer setBorderColor:RGB(240, 240, 240).CGColor];
        [self addSubview:cancelBtn];
        _cancelBtn = cancelBtn;
        
        UIButton *okBtn = [[UIButton alloc] init];
        [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [okBtn setTitle:LOCALIZEDSTRING(@"ok") forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [okBtn.layer setBorderWidth:1.0];
        [okBtn.layer setBorderColor:RGB(240, 240, 240).CGColor];
        [self addSubview:okBtn];
        _okBtn = okBtn;
        
    }
    
    return self;
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    if (!minimumDate) {
        DLog(@"minimun is nil!");
        return;
    }
    
    _minimumDate = minimumDate;
    _datePicker.minimumDate = minimumDate;
    _datePicker.maximumDate = nil;
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    if (!maximumDate) {
        DLog(@"minimun is nil!");
        return;
    }
    
    _datePicker.minimumDate = nil;
    _maximumDate = maximumDate;
    _datePicker.maximumDate = maximumDate;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    ELockWeakSelf();
    [_issuanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).offset(20.0);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-20.0);
        make.top.mas_equalTo(weakSelf.mas_top).offset(20.0);
        make.height.equalTo(@(30));
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.issuanceLabel.mas_bottom).offset(20.0);
        make.height.equalTo(@(1.0));
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@(44));
    }];
    
    [_okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right);
        make.left.mas_equalTo(weakSelf.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@(44));
    }];
    
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(weakSelf.imageView).offset(5.0);
        make.bottom.mas_equalTo(weakSelf.cancelBtn.mas_top).offset(-5.0);
    }];
}
- (void)cancel:(UIButton *)button {
    [self hide];
}

- (void)ok:(UIButton *)button {
    ELockWeakSelf();
    [self hideWithBlock:^(MMPopupView *popView, BOOL bFinished) {
        NSDate *theDate = weakSelf.datePicker.date;
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(issuanceViewDate:)]) {
            [weakSelf.delegate issuanceViewDate:theDate];
        }
        
        if (self.block) {
            self.block(theDate, self.baseTag);
        }
        
    }];
}
@end
