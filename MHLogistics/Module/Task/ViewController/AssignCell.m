//
//  AssignCell.m
//  MHLogistics
//
//  Created by wjc on 10/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "AssignCell.h"
#import "HomeCell.h"

CGFloat kAssignPaddingLeft = 16.0;
CGFloat kAssignPaddingTop = 5.0;
CGFloat kAssignWidth = 80;
CGFloat kAssignHeight = 30;
CGFloat kAssignPadding = 0;
CGFloat kAssignHeader = 30;

@interface AssignCell()

@property (nonatomic, assign) CGRect baseRect;
@property (nonatomic, weak) UIView *baseView;
@property (nonatomic, weak) UIView *clearView;

@end

@implementation AssignCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.frame = CGRectMake(0, 0, kScreenWidth, kHCHeight-40);
        [self initUI];
    }
    
    return self;
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

- (void)initUI {
    [self.contentView addSubview:self.baseView];
    
//    [self.contentView addSubview:self.clearView];
    [self.baseView addSubview:self.singTitleLabel];
    [self.baseView addSubview:self.singLabel];
    [self.baseView addSubview:self.seamlessTitleLabel];
    [self.baseView addSubview:self.seamlessLabel];
    [self.baseView addSubview:self.weightTitleLabel];
    [self.baseView addSubview:self.weighLabel];
    [self.baseView addSubview:self.numberTitleLabel];
    [self.baseView addSubview:self.numberLabel];
    [self.baseView addSubview:self.numberTTitleLabel];
    [self.baseView addSubview:self.numberTLabel];
}

- (UIView *)clearView {
    if (_clearView) {
        return _clearView;
    }
    
    CGFloat height = self.contentView.frame.size.height;
    CGRect baseRect = CGRectMake(5 + 1, 5, kScreenWidth-5*2- 1*2, height-5-1*2);
    UIView *clearView = [[UIView alloc] initWithFrame:baseRect];
    clearView.backgroundColor = [UIColor whiteColor];
    _clearView = clearView;
    return clearView;
}

- (UILabel *)singTitleLabel {
    if (_singTitleLabel) {
        return _singTitleLabel;
    }
        
    UILabel *singTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAssignPaddingLeft, kAssignPadding, kAssignWidth, kAssignHeight)];
    singTitleLabel.font = [UIFont systemFontOfSize:13.0];
    singTitleLabel.text = LOCALIZEDSTRING(@"assignSingleNumber");
    _singTitleLabel = singTitleLabel;
    return singTitleLabel;
}

- (UILabel *)singLabel {
    if (_singLabel) {
        return _singLabel;
    }
    
    UILabel *singLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAssignPaddingLeft + kAssignWidth +kAssignPadding, _singTitleLabel.frame.origin.y + kAssignHeight + 5, kAssignWidth, kAssignHeight)];
    singLabel.font = [UIFont systemFontOfSize:13.0];
    _singLabel = singLabel;
    return singLabel;
}
    
- (UILabel *)seamlessTitleLabel {
    if (_seamlessTitleLabel) {
        return _seamlessTitleLabel;
    }
        
    UILabel *seamlessTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAssignPaddingLeft, _singTitleLabel.frame.origin.y + kAssignHeight + 10, kAssignWidth, kAssignHeight)];
    seamlessTitleLabel.font = [UIFont systemFontOfSize:13.0];
    seamlessTitleLabel.text = LOCALIZEDSTRING(@"assignSeamLess");
    _seamlessTitleLabel = seamlessTitleLabel;
    return seamlessTitleLabel;

}

- (UILabel *)seamlessLabel {
    if (_seamlessLabel) {
        return _seamlessLabel;
    }
    
    UILabel *seamlessLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAssignPaddingLeft + kAssignWidth +kAssignPadding, _seamlessTitleLabel.frame.origin.y + kAssignHeight + 5, kAssignWidth, kAssignHeight)];
    seamlessLabel.font = [UIFont systemFontOfSize:13.0];
    _seamlessLabel = seamlessLabel;
    return _seamlessLabel;
}



- (UILabel *)weightTitleLabel {
    if (_weightTitleLabel) {
        return _weightTitleLabel;
    }
        
    UILabel *weightTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAssignPaddingLeft, _seamlessTitleLabel.frame.origin.y + kAssignHeight + kAssignPadding, kAssignWidth, kAssignHeight)];
    weightTitleLabel.font = [UIFont systemFontOfSize:13.0];
    weightTitleLabel.text = LOCALIZEDSTRING(@"assignWeight");
    _weightTitleLabel = weightTitleLabel;
    return weightTitleLabel;
}

- (UILabel *)weighLabel {
    if (_weighLabel) {
        return _weighLabel;
    }
    
    UILabel *weighLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAssignPaddingLeft + kAssignWidth +10, _weightTitleLabel.frame.origin.y + kAssignHeight + 5, kAssignWidth, kAssignHeight)];
    weighLabel.font = [UIFont systemFontOfSize:13.0];
    _weighLabel = weighLabel;
    return _weighLabel;
}


- (UILabel *)numberTitleLabel {
    if (_numberTitleLabel) {
        return _numberTitleLabel;
    }
        
    UILabel *numberTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAssignPaddingLeft, _weightTitleLabel.frame.origin.y + kAssignHeight + kAssignPadding, kAssignWidth, kAssignHeight)];
    numberTitleLabel.font = [UIFont systemFontOfSize:13.0];
    numberTitleLabel.text = LOCALIZEDSTRING(@"assignNumber");
    _numberTitleLabel = numberTitleLabel;
    return numberTitleLabel;
}

- (UILabel *)numberLabel {
    if (_numberLabel) {
        return _numberLabel;
    }
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAssignPaddingLeft + kAssignWidth +10, _numberTitleLabel.frame.origin.y + kAssignHeight + 5, kAssignWidth, kAssignHeight)];
    numberLabel.font = [UIFont systemFontOfSize:13.0];
    _numberLabel = numberLabel;
    return _numberLabel;
}

- (UILabel *)numberTTitleLabel {
    if (_numberTTitleLabel) {
        return _numberTTitleLabel;
    }

    UILabel *numberTTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAssignPaddingLeft, _numberTitleLabel.frame.origin.y + kAssignHeight + kAssignPadding, kAssignWidth, kAssignHeight)];
    numberTTitleLabel.font = [UIFont systemFontOfSize:13.0];
    numberTTitleLabel.text = LOCALIZEDSTRING(@"assignNumberT");
    _numberTTitleLabel = numberTTitleLabel;
    return numberTTitleLabel;
}

- (UILabel *)numberTLabel {
    if (_numberTLabel) {
        return _numberTLabel;
    }
    
    UILabel *numberTLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAssignPaddingLeft + kAssignWidth +10, _numberTTitleLabel.frame.origin.y + kAssignHeight + 5, kAssignWidth, kAssignHeight)];
    numberTLabel.font = [UIFont systemFontOfSize:13.0];
    _numberTLabel = numberTLabel;
    return _numberTLabel;
}

@end
