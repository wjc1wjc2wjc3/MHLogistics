//
//  VehicleManageCell.h
//  MHLogistics
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VehicleManageCell : UITableViewCell

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

NS_ASSUME_NONNULL_END
