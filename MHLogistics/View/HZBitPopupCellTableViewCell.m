//
//  HZBitPopupCellTableViewCell.m
//  HZBitApp
//
//  Created by Apple on 8/31/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "HZBitPopupCellTableViewCell.h"

@interface HZBitPopupCellTableViewCell(){
    UILabel *_popTitleLabel;
}

@end

@implementation HZBitPopupCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect frame = self.contentView.frame;
        UILabel *popTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, frame.origin.y, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [popTitleLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:popTitleLabel];
        _popTitleLabel = popTitleLabel;
    }
    return self;
}

- (void)setPopTitle:(NSString *)popTitle {
    if (popTitle) {
        [_popTitleLabel setText:popTitle];
    }
}

@end
