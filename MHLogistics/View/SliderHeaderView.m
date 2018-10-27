//
//  SliderHeaderView.m
//  MHLogistics
//
//  Created by wjc on 10/27/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "SliderHeaderView.h"

@interface SliderHeaderView()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, assign) NSUInteger curIdx;
@property (nonatomic, weak) UIView *lineView;

@end

@implementation SliderHeaderView

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array {
    self = [super initWithFrame:frame];
    if (self) {
        _titleArray = array;
        [self initUI];
        _curIdx = -1;
        [self setCurIdx:0];
    }
    return self;
}

- (void)initUI {
    CGFloat width = CGRectGetWidth(self.frame);
    NSInteger count = _titleArray.count;
    CGFloat widthf = width/count;
    _labelArray = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(widthf*i, 0, widthf, CGRectGetHeight(self.frame))];
        label.text = _titleArray[i];
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = i;
        label.textColor = [UIColor blackColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [label addGestureRecognizer:tapGesture];
        [self addSubview:label];
        [_labelArray addObject:label];
    }
    
    [self addSubview:self.lineView];
}

- (UIView *)lineView {
    if (_lineView) {
        return _lineView;
    }
    
    CGFloat width = self.frame.size.width/_titleArray.count;
    CGFloat y = self.frame.size.height - 1;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, y, width, 1)];
    lineView.backgroundColor = MainColor;
    _lineView = lineView;
    
    return _lineView;
}

- (void)tapAction:(UITapGestureRecognizer *)recognizer {
    UILabel *label = (UILabel *)[recognizer view];
    NSInteger tag = label.tag;
    [self setCurIdx:tag];
}

- (void)setCurIdx:(NSUInteger)curIdx {
    if (_curIdx == curIdx) {
        DLog(@"same idx");
        return;
    }
    
    _curIdx = curIdx;
    
    for (NSUInteger i = 0; i < _labelArray.count; i++) {
        UILabel *label = _labelArray[i];
        UIColor *color = i == curIdx ? MainColor : GrayColor;
        label.textColor= color;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = self->_lineView.frame;
        self->_lineView.frame = CGRectMake(rect.size.width*curIdx, rect.origin.y, rect.size.width, 1);
    }];
    
    if (self.block) {
        self.block(curIdx);
    }
    
}

@end
