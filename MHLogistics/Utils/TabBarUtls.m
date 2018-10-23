//
//  TabBarUtls.m
//  HZBitApp
//
//  Created by Apple on 9/4/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "TabBarUtls.h"

@implementation TabBarUtls

+ (void)setTabBarHeight:(CGFloat)height {
    if (tabBarHeight == 0.0) {
        tabBarHeight = height;
    }
}

+ (CGFloat)getTabBarHeight {
    return tabBarHeight;
}

@end
