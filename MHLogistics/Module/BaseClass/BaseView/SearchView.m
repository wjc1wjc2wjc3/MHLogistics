//
//  SearchView.m
//  HZBitSmartLock
//
//  Created by Apple on 2018/6/4.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "SearchView.h"



@interface SearchView()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textTF;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation SearchView {
    BOOL _bShowSearch;
    NSArray *_resArray;
    OperationPicType _type;
    CGRect _modifyRect;
}

- (instancetype)initWithFrame:(CGRect)frame authType:(OperationPicType)type {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _resArray = @[@"icon_guider_auth_app", @"icon_guider_auth_idcard", @"icon_guider_auth_idcard_a", @"icon_guider_auth_wx"];
        _bShowSearch = type == noAnyAuthorized ? YES : NO;
        _type = type;
        _modifyRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        [self layoutIfNeeded];
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _modifyRect.size.height = 0;
    CGFloat textHeightTF = 0;
    CGFloat imageY = 0;
    if (_bShowSearch) {
        CGRect frame = self.textTF.frame;
        textHeightTF = frame.size.height;
        imageY = frame.size.height;
    }
    else
    {
        if (_textTF) {
            [_textTF removeFromSuperview];
            _textTF = nil;
        }

        textHeightTF = 0;
        _modifyRect.origin.y = 0;
    }
    
    _modifyRect.size.height = textHeightTF;
    if (_type != noAnyAuthorized) {
        CGFloat paddingTop = 20;
        imageY += paddingTop;
        UIImageView *imageView = self.imageView;
        CGRect rect = imageView.frame;
        imageView.frame = CGRectMake(rect.origin.x, imageY, rect.size.width, rect.size.height);
        _modifyRect.size.height = textHeightTF + CGRectGetHeight(rect) + paddingTop;
        imageView.transform = CGAffineTransformMakeTranslation(0, imageY);
    }
    self.frame = _modifyRect;
}

- (UIImageView *)imageView {
    if (_imageView) {
        return _imageView;
    }
    
    NSString *resId = _resArray[_type];
    UIImage *image = [UIImage imageNamed:resId];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    MHWeakSelf();
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    _imageView = imageView;
    
    return _imageView;
}

- (UITextField *)textTF {
    if (_textTF) {
        return _textTF;
    }
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(kSearchPadding, 0, CGRectGetWidth(self.frame) - kSearchPadding * 2, kSearchHeight - 1)];
    textField.delegate = self;
    textField.keyboardType = UIKeyboardTypeDefault;
    NSString *placeholder = LOCALIZEDSTRING(@"inputLockName");
    textField.placeholder = placeholder;
    [self addSubview:textField];
    _textTF = textField;
    return _textTF;
}

- (void)changeSearch {

    _bShowSearch = !_bShowSearch;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, SPLIT_LINE_COLOR.CGColor);
    CGContextMoveToPoint(context, kSearchPadding, kSearchHeight - 1);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.textTF.frame) + kSearchPadding, kSearchHeight - 1);
    CGContextStrokePath(context);
}

#pragma mark
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(SearchResult:)]) {
        [_delegate SearchResult:textField.text];
    }
}

@end
