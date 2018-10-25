//
//  SettingCell.h
//  MHLogistics
//
//  Created by Apple on 2018/10/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingCell : UITableViewCell

@property (nonatomic, weak) UILabel *mainLabel;
@property (nonatomic, weak) UILabel *rightLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
