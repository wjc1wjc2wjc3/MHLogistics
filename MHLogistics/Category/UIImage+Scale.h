//
//  UIImage+Scale.h
//  HZBitApp
//
//  Created by Apple on 8/30/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
+ (UIImage *)circleImage:(UIImage *)image withParam:(CGFloat)inset;
@end
