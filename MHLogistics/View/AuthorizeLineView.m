//
//  AuthorizeLineView.m
//  MHLogistics
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "AuthorizeLineView.h"

CGFloat kRadius = 20.0f;
CGFloat kTriangle = 3.0f;
CGFloat kPadding = 30.0f;

@interface AuthorizeLineView ()

@property (nonatomic, strong)NSArray *titleArray;

@end

@implementation AuthorizeLineView


- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)bottomArray {
    if (self = [super initWithFrame:frame]) {
        _titleArray = bottomArray;
        _currentIdx = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)setCurrentIdx:(NSUInteger)currentIdx {
    _currentIdx = currentIdx;
}


- (void)drawRect:(CGRect)rect {
    
    
   CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    CGFloat width = CGRectGetWidth(self.frame);
    NSInteger count = _titleArray.count;
    CGFloat labelWidth = self.frame.size.width/count;
    CGFloat triangleHeight = sqrt(pow(kTriangle, 2) - pow(kTriangle*0.5, 2));
    CGFloat distance = (width - kPadding*2 - 2*kRadius*count - triangleHeight*(count - 1))/(count - 1);
    CGPoint lastCenter = CGPointZero;
    for (NSUInteger i = 0; i < _titleArray.count; i++) {
//        CGFloat x = kPadding + i*(kRadius*2 + distance + triangleHeight);
        
//        CGFloat x = labelWidth*0.5 - kRadius*0.5;
        
        //文字
        NSString *wordText = _titleArray[i];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
        paragraph.alignment = NSTextAlignmentCenter;//居中
        NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraph};
        CGRect textRect = CGRectMake(labelWidth*i, self.frame.size.height - 20, labelWidth, 20);
        [wordText drawInRect:textRect withAttributes:attrs];
        CGPoint center = CGPointMake(textRect.origin.x + textRect.size.width*0.5, textRect.origin.y);
        
        //实心圆
        CGContextBeginPath(ctx);
        UIColor *color = i == _currentIdx ? BlueColor : DeepColor;
        CGColorRef cgColor = color.CGColor;
        const CGFloat *colorComponents = CGColorGetComponents(cgColor);
        CGContextSetRGBFillColor(ctx, colorComponents[0], colorComponents[1], colorComponents[2], colorComponents[3]);
        CGContextAddEllipseInRect(ctx, CGRectMake(center.x - kRadius, 0, kRadius, kRadius));
        CGContextFillPath(ctx);
        
        //直线
        if (i > 0) {
            CGContextBeginPath(ctx);
            UIColor *color = DeepColor;
            CGColorRef cgColor = color.CGColor;
            const CGFloat *colorComponents = CGColorGetComponents(cgColor);
            CGContextSetRGBStrokeColor(ctx, colorComponents[0], colorComponents[1], colorComponents[2], colorComponents[3]);
            CGContextSetLineWidth(ctx, 1.0);
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextSetLineJoin(ctx, kCGLineJoinRound);
            CGContextMoveToPoint(ctx, lastCenter.x, kRadius*0.5);
            CGContextAddLineToPoint(ctx, center.x - triangleHeight*2, kRadius*0.5);
            CGContextStrokePath(ctx);

            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, center.x - kRadius - triangleHeight, kRadius*0.5 - kTriangle*0.5);
            CGContextAddLineToPoint(ctx, center.x - kRadius, kRadius*0.5);
            CGContextAddLineToPoint(ctx, center.x - kRadius - triangleHeight, kRadius*0.5 + kTriangle*0.5);
            CGContextClosePath(ctx);
            [[UIColor blackColor] setFill];
            CGContextDrawPath(ctx, kCGPathFillStroke);
        }
        
        lastCenter = center;
    }
}


@end
