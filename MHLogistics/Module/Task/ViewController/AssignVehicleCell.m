//
//  AssignVehicleCell.m
//  MHLogistics
//
//  Created by wjc on 10/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "AssignVehicleCell.h"

CGFloat kAssignVehicleCellHeight = 140.0f;
CGFloat kAssignSelectedZoneWidth = 50;

@implementation AssignVehicleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.frame = CGRectMake(0, 0, kScreenWidth, kAssignVehicleCellHeight);
        [self.contentView addSubview:self.clearView];
        [self.contentView addSubview:self.selectedBtn];
        [self.clearView addSubview:self.licensePlateImageView];
        [self.clearView addSubview:self.licensePlateLabel];
        [self.clearView addSubview:self.distanceLabel];
        [self.clearView addSubview:self.distanceImageView];
        [self.clearView addSubview:self.amountImageView];
        [self.clearView addSubview:self.amountLabel];
        [self.clearView addSubview:self.tImageView];
        [self.clearView addSubview:self.tLabel];
        [self.clearView addSubview:self.timeImageView];
        [self.clearView addSubview:self.timeLabel];
    }
    
    return self;
}

- (UIButton *)selectedBtn {
    if (_selectedBtn) {
        return _selectedBtn;
    }
    UIButton *selectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    [selectedBtn addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectedBtn setImage:[UIImage imageNamed:@"btn_uncheck"] forState:UIControlStateNormal];
    selectedBtn.bSelected = NO;
    _selectedBtn = selectedBtn;
    selectedBtn.center = CGPointMake(selectedBtn.center.x, _clearView.center.y);
    return selectedBtn;
}

- (void)checkAction:(UIButton *)button {
    DLog(@"checkAction");
    BOOL bSelected =  button.bSelected;
    bSelected  = !bSelected;
    [_selectedBtn setBSelected:bSelected];
    NSString *iconRes = bSelected ? @"btn_check" : @"btn_uncheck";
    [_selectedBtn setImage:[UIImage imageNamed:iconRes] forState:UIControlStateNormal];
    
}



- (UIImageView *)licensePlateImageView {
    if (_licensePlateImageView) {
        return _licensePlateImageView;
    }
    
    UIImageView *licensePlateImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_icon"]];
    licensePlateImageView.frame = CGRectMake(16, 10, 20, 20);
    _licensePlateImageView = licensePlateImageView;
    return licensePlateImageView;
}

- (UILabel *)licensePlateLabel {
    if (_licensePlateLabel) {
        return _licensePlateLabel;
    }
    UILabel *licensePlateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_licensePlateImageView.frame.origin.x + _licensePlateImageView.frame.size.width + 5, 10, 150, 20)];
    licensePlateLabel.font = [UIFont systemFontOfSize:12.0];
    licensePlateLabel.textAlignment = NSTextAlignmentLeft;
    _licensePlateLabel = licensePlateLabel;
    
    return licensePlateLabel;
}

- (UIImageView *)distanceImageView {
    if (_distanceImageView) {
        return _distanceImageView;
    }
    
    UIImageView *distanceImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_icon"]];
    distanceImageView.frame = CGRectMake(_distanceLabel.frame.origin.x - 20 - 5, 10, 20, 20);
    _distanceImageView = distanceImageView;
    return distanceImageView;
}

- (UILabel *)distanceLabel {
    if (_distanceLabel) {
        return _distanceLabel;
    }
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.clearView.frame.size.width-40-10, 10, 40, 20)];
    distanceLabel.font = [UIFont systemFontOfSize:12.0];
    distanceLabel.textAlignment = NSTextAlignmentRight;
    _distanceLabel = distanceLabel;
    
    return distanceLabel;
}

- (UIImageView *)amountImageView {
    if (_amountImageView) {
        return _amountImageView;
    }
    
    UIImageView *amountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_icon"]];
    amountImageView.frame = CGRectMake(16, _licensePlateLabel.frame.origin.y + _licensePlateLabel.frame.size.height + 10, 20, 20);
    _amountImageView = amountImageView;
    return amountImageView;
}

- (UILabel *)amountLabel {
    if (_amountLabel) {
        return _amountLabel;
    }
    CGFloat x  = _amountImageView.frame.origin.x + _amountImageView.frame.size.width + 5;
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, _amountImageView.frame.origin.y, self.clearView.frame.size.width - x, 20)];
    amountLabel.font = [UIFont systemFontOfSize:12.0];
    amountLabel.textAlignment = NSTextAlignmentLeft;
    _amountLabel = amountLabel;
    
    return _amountLabel;
}

- (UIImageView *)tImageView {
    if (_tImageView) {
        return _tImageView;
    }
    
    UIImageView *tImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_icon"]];
    tImageView.frame = CGRectMake(16, _amountLabel.frame.origin.y + _amountLabel.frame.size.height + 10, 20, 20);
    _tImageView = tImageView;
    return tImageView;
}

- (UILabel *)tLabel {
    if (_tLabel) {
        return _tLabel;
    }
    CGFloat x  = _tImageView.frame.origin.x + _tImageView.frame.size.width + 5;
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, _tImageView.frame.origin.y, self.clearView.frame.size.width - x, 20)];
    tLabel.font = [UIFont systemFontOfSize:12.0];
    tLabel.textAlignment = NSTextAlignmentLeft;
    _tLabel = tLabel;
    
    return tLabel;
}

- (UIImageView *)timeImageView {
    if (_timeImageView) {
        return _timeImageView;
    }
    
    UIImageView *timeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_icon"]];
    timeImageView.frame = CGRectMake(16, _tLabel.frame.origin.y + _tLabel.frame.size.height + 10, 20, 20);
    _timeImageView = timeImageView;
    return timeImageView;
}

- (UILabel *)timeLabel {
    if (_timeLabel) {
        return _timeLabel;
    }
    CGFloat x  = _timeImageView.frame.origin.x + _timeImageView.frame.size.width + 5;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, _timeImageView.frame.origin.y, self.clearView.frame.size.width - x, 20)];
    timeLabel.font = [UIFont systemFontOfSize:12.0];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel = timeLabel;
    
    return timeLabel;
}

- (UIView *)clearView {
    if (_clearView) {
        return _clearView;
    }
    
    CGRect rect = self.contentView.frame;
    CGRect baseRect = CGRectMake(kAssignSelectedZoneWidth, 5, rect.size.width-5- kAssignSelectedZoneWidth, rect.size.height-5*2);
    UIView *clearView = [[UIView alloc] initWithFrame:baseRect];
    clearView.backgroundColor = HomeGrayColor;
    clearView.layer.cornerRadius = 10;
    clearView.layer.masksToBounds = YES;
    clearView.layer.borderWidth =1.0;
    clearView.layer.borderColor = GrayColor.CGColor;
    _clearView = clearView;
    return clearView;
}

@end
