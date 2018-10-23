//
//  IssuanceView.h
//  HZBitApp
//
//  Created by Apple on 9/1/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <MMPopupView/MMPopupView.h>

@protocol IssuanceViewDateDelegate <NSObject>

@optional
- (void)issuanceViewDate:(NSDate *)date;

@end

typedef void(^issuanceBlock)(NSDate *date, NSInteger tag);

@interface IssuanceView : MMPopupView

- (instancetype)initIssuanceView:(UIDatePickerMode)mode startDate:(BOOL)bStart;

@property(nonatomic,weak)id delegate;

@property(nonatomic, assign) NSInteger baseTag;
@property(nonatomic, copy)issuanceBlock block;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSDate *maximumDate;

@end
