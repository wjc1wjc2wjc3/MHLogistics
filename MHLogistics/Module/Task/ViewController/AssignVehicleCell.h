//
//  AssignVehicleCell.h
//  MHLogistics
//
//  Created by wjc on 10/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Extension.h"

extern CGFloat kAssignVehicleCellHeight;

@interface AssignVehicleCell : UITableViewCell

@property (nonatomic, weak) UIView *clearView;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) UIImageView *licensePlateImageView;
@property (nonatomic, weak) UILabel *licensePlateLabel;
@property (nonatomic, weak) UIImageView *distanceImageView;
@property (nonatomic, weak) UILabel *distanceLabel;
@property (nonatomic, weak) UIImageView *amountImageView;
@property (nonatomic, weak) UILabel *amountLabel;
@property (nonatomic, weak) UIImageView *tImageView;
@property (nonatomic, weak) UILabel *tLabel;
@property (nonatomic, weak) UIImageView *timeImageView;
@property (nonatomic, weak) UILabel *timeLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

@end
