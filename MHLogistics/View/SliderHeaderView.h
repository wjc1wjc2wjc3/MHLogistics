//
//  SliderHeaderView.h
//  MHLogistics
//
//  Created by wjc on 10/27/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sliderHeaderBlock)(NSUInteger tag);

@interface SliderHeaderView : UIView

@property (nonatomic, copy) sliderHeaderBlock block;

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array;

@end
