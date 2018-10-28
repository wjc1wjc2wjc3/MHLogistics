//
//  AssignCell.h
//  MHLogistics
//
//  Created by wjc on 10/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignCell : UITableViewCell

@property (nonatomic, weak) UILabel *singTitleLabel; //六联单号
@property (nonatomic, weak) UILabel *singLabel;
@property (nonatomic, weak) UILabel *seamlessTitleLabel;//无缝号
@property (nonatomic, weak) UILabel *seamlessLabel;
@property (nonatomic, weak) UILabel *weightTitleLabel; //报关重量
@property (nonatomic, weak) UILabel *weighLabel;
@property (nonatomic, weak) UILabel *numberTitleLabel; //报关件数
@property (nonatomic, weak) UILabel *numberLabel;
@property (nonatomic, weak) UILabel *numberTTitleLabel;//报关件数
@property (nonatomic, weak) UILabel *numberTLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

@end
