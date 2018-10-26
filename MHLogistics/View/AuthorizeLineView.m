//
//  AuthorizeLineView.m
//  MHLogistics
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "AuthorizeLineView.h"

CGFloat kRadius = 5.0f;
CGFloat kTriangle = 2.0f;
CGFloat kPadding = 30.0f;

@interface AuthorizeLineView ()

@property (nonatomic, strong)NSArray *titleArray;

@end

@implementation AuthorizeLineView


- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)bottomArray {
    if (self = [super initWithFrame:frame]) {
        _titleArray = bottomArray;
        _currentIdx = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    if (_titleLabelArray) {
//        return;
//    }
//
//    CGFloat labelWidth = self.frame.size.width/3;
//    for (NSUInteger i = 0; i < _titleArray.count; i++) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth*i, self.frame.size.height - 20, labelWidth, 20)];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:13.0];
//        label.text = _titleArray[i];
//        [self addSubview:label];
//        [_titleLabelArray addObject:label];
//    }
    
}

- (void)setCurrentIdx:(NSUInteger)currentIdx {
    _currentIdx = currentIdx;
}


- (void)drawRect:(CGRect)rect {
    
   CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat width = CGRectGetWidth(self.frame);
    NSInteger count = _titleArray.count;
    CGFloat labelWidth = self.frame.size.width/count;
    CGFloat triangleHeight = sqrt(pow(kTriangle, 2) + pow(kTriangle*0.5, 2));
    CGFloat distance = (width - kPadding*2 - 2*kRadius*count - triangleHeight*(count - 1))/(count - 1);
    for (NSUInteger i = 0; i < _titleArray.count; i++) {
        CGFloat x = width - kPadding - i*(kRadius*2) - distance*i;
        
        //实心圆
        CGContextBeginPath(ctx);
        UIColor *color = i == _currentIdx ? BlueColor : DeepColor;
        CIColor *ciColor = color.CIColor;
        CGContextSetRGBFillColor(ctx, ciColor.red, ciColor.green, ciColor.blue, ciColor.alpha);
        CGContextAddEllipseInRect(ctx, CGRectMake(x+kRadius, kRadius, kRadius, kRadius));
        CGContextFillPath(ctx);
        
        //直线
        CGFloat alpha = ciColor.alpha;
        CGContextBeginPath(ctx);
        CGContextSetRGBStrokeColor(ctx, 0.0, 0.0, 0.0, alpha);
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextSetLineJoin(ctx, kCGLineJoinRound);
        CGContextMoveToPoint(ctx, x+kRadius*2, kRadius);
        CGContextAddLineToPoint(ctx, x+kRadius*2 + distance, kRadius);
        CGContextStrokePath(ctx);
        
        //三角形
        if (i > 0) {
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, x+kRadius*2 + distance, kRadius - kTriangle*0.5);
            CGContextAddLineToPoint(ctx, x+kRadius*2 + distance + triangleHeight, kRadius);
            CGContextAddLineToPoint(ctx, x+kRadius*2 + distance, kRadius + kTriangle*0.5);
            CGContextClosePath(ctx);
            [[UIColor blackColor] setFill];
            CGContextDrawPath(ctx, kCGPathFillStroke);
        }
        
        //文字
        NSString *wordText = _titleArray[i];
        NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor]};
        [wordText drawInRect:CGRectMake(labelWidth*i, self.frame.size.height - 20, labelWidth, 20) withAttributes:attrs];
    }
}


@end
