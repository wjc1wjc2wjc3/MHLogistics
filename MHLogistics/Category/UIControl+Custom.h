//
//  UIControl+Custom.h
//  HZBitSmartLock
//
//  Created by Apple on 2018/6/8.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^callBack)(void);

@interface UIControl (Custom)

@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;// 可以用这个给重复点击加间隔
@property (nonatomic,strong) void (^callBack)(void);//在不响应时可以提示用户点击过于频繁等操作

@end
