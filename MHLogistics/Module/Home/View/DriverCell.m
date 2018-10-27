//
//  DriverCell.m
//  MHLogistics
//
//  Created by Apple on 2018/10/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "DriverCell.h"

@interface DriverCell ()

@end

@implementation DriverCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = GrayColor;
    }
    return self;
}

- (void)layoutSubviews {
    
}

@end
