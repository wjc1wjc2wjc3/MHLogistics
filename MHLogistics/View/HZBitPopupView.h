//
//  HZBItPopupView.h
//  HZBitApp
//
//  Created by Apple on 8/31/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <MMPopupView/MMPopupView.h>

typedef void(^HZBitPopupViewSelectedBlock)(NSInteger index);

@protocol HZBitPopupViewDelegate <NSObject>

@optional
- (void)HZBitPopupViewItemSelected:(NSUInteger)tag index:(NSUInteger)index;

@end

@interface HZBitPopupView : MMPopupView

- (instancetype)initHZBitPopupView:(NSArray *)dataArray;

@property(nonatomic,weak)id delegate;
@property(nonatomic,copy) HZBitPopupViewSelectedBlock block;

@end
