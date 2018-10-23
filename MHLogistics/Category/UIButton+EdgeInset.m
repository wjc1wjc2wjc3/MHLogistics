//
//  UIButton+EdgeInset.m
//  HZBitApp
//
//  Created by Apple on 9/1/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "UIButton+EdgeInset.h"

@implementation UIButton (EdgeInset)


- (void)setEdgeInset{
    CGRect frame = self.frame;
    CGRect imageRect = self.imageView.frame;
    CGRect titleRect = self.titleLabel.frame;
    CGFloat heightSpace = 20.0f;
    [self setImageEdgeInsets:UIEdgeInsetsMake(heightSpace, 0, frame.size.height - imageRect.size.height - heightSpace, -titleRect.size.width)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageRect.size.height + heightSpace, -imageRect.size.width, 0, 0)];
    
}

@end
