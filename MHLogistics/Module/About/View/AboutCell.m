//
//  AboutCell.m
//  MHLogistics
//
//  Created by Apple on 2018/10/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "AboutCell.h"

@implementation AboutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.rightLabel];
        [self.contentView addSubview:self.mainLabel];
    }
    
    return self;
}

- (UILabel *)rightLabel {
    if (_rightLabel) {
        return _rightLabel;
    }
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width, 0, 40, 40)];
    rightLabel.font = [UIFont systemFontOfSize:12.0];
    rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel = rightLabel;
    
    return rightLabel;
}

- (UILabel *)mainLabel {
    if (_mainLabel) {
        return _mainLabel;
    }
    CGFloat x = 60;
    UILabel *mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, _rightLabel.frame.origin.x - x, 40)];
    _mainLabel = mainLabel;
    

    return mainLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.rightLabel.center = CGPointMake(self.rightLabel.center.x, self.contentView.frame.size.height*0.5);
    self.mainLabel.center = CGPointMake(self.mainLabel.center.x, self.contentView.frame.size.height*0.5);
        DLog(@" %f, %f", self.imageView.center.y, self.contentView.frame.size.height*0.5);
}

@end
