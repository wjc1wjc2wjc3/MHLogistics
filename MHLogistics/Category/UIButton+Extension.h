//
//  UIButton+Extension.h
//  HZBitSmartLock
//
//  Created by Apple on 10/31/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

@property (nonatomic, assign) BOOL bSelected;
@property (nonatomic, assign) BOOL bEyeClosed;

@property (nonatomic, assign) NSTimeInterval acceptEventInterval; // 重复点击的间隔

@end
