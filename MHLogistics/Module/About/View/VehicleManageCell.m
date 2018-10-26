//
//  VehicleManageCell.m
//  MHLogistics
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VehicleManageCell.h"

@implementation VehicleManageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.licensePlateImageView];
        [self.contentView addSubview:self.licensePlateLabel];
        [self.contentView addSubview:self.distanceLabel];
        [self.contentView addSubview:self.distanceImageView];
        [self.contentView addSubview:self.amountImageView];
        [self.contentView addSubview:self.amountLabel];
        [self.contentView addSubview:self.tImageView];
        [self.contentView addSubview:self.tLabel];
        [self.contentView addSubview:self.timeImageView];
        [self.contentView addSubview:self.timeLabel];
    }
    
    return self;
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
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width, 10, 40, 20)];
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
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, _amountImageView.frame.origin.y, self.contentView.frame.size.width - x, 20)];
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
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, _tImageView.frame.origin.y, self.contentView.frame.size.width - x, 20)];
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
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, _timeImageView.frame.origin.y, self.contentView.frame.size.width - x, 20)];
    timeLabel.font = [UIFont systemFontOfSize:12.0];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel = timeLabel;
    
    return timeLabel;
}


@end
