//
//  UIImage+CircleImage.m
//  HZBitApp
//
//  Created by Apple on 8/31/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)

- (UIImage *)drawCircleImage {
    CGFloat side = MIN(self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side),false, [UIScreen mainScreen].scale);
    
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     
                     [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0, side, side)].CGPath);
    
    CGContextClip(UIGraphicsGetCurrentContext());
    
    CGFloat marginX = -(self.size.width - side) /2.f;
    CGFloat marginY = -(self.size.height - side) /2.f;
    [self drawInRect:CGRectMake(marginX, marginY, self.size.width, self.size.height)];
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
}

@end
