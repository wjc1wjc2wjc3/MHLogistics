//
//  BitButton.m
//  HZBitSmartLock
//
//  Created by Apple on 26/03/2018.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "BitButton.h"

@implementation BitButton

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
}

@end
