//
//  MHPopMenuView.h
//  MHLogistics
//
//  Created by wjc on 10/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopMenuModel;

typedef void(^MHPopMenuBlock)(NSInteger selectedIndex, PopMenuModel *model);


@interface MHPopMenuView : UIView

@property (nonatomic, copy) void(^hideHandle)(void);
@property (nonatomic, copy) MHPopMenuBlock action;

/**
 *  类方法展示
 *
 *  @param dataArray  PopMenuModel类型元素
 *  @param width  宽度
 *  @param point  三角的顶角坐标（基于window）
 *  @param action 点击回调
 */
+ (void)popWithDataArray:(NSArray<PopMenuModel *> *)dataArray
                   width:(CGFloat)width
        triangleLocation:(CGPoint)point
                  action:(MHPopMenuBlock)action;

- (void)show;
- (void)hide;

@end
