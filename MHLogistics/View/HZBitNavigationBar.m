//
//  HZBitNavigationBar.m
//  HZBitApp
//
//  Created by Apple on 9/2/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "HZBitNavigationBar.h"
#import "UIImage+Color.h"

typedef NS_OPTIONS(NSUInteger, eRightType) {
    eSearchType = 0,
    eCommonType
};

@implementation HZBitNavigationBar {
    UIButton *_backButton;
    UIButton *_rightButton;
    CGRect    _rbRect;
    UIImage *_rightItem;
    UIFont *_rightFont;
    eRightType _rightType;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *image = [UIImage createImageWithColor:MainColor];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
        NSDictionary *attributeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont systemFontOfSize:16.0],NSFontAttributeName, nil];
        self.titleTextAttributes = attributeDictionary;
        
        [self addBackItem];
        
    }
    return self;
}

- (void)addBackItem{
    UIImage *backImage = [UIImage imageNamed:@"back"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, NAVIGATIONBAR_HEIGHT, NAVIGATIONBAR_HEIGHT)];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backItem:) forControlEvents:UIControlEventTouchUpInside];
    _backButton = backButton;
    UIBarButtonItem *leftNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    navigationItem.leftItemsSupplementBackButton = YES;
    [navigationItem setLeftBarButtonItem:leftNavigationItem];
    
    _rightItem = [UIImage imageNamed:@"icon_menu"];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, NAVIGATIONBAR_HEIGHT * 1.2, NAVIGATIONBAR_HEIGHT)];
    [rightButton setTitle:LOCALIZEDSTRING(@"menuAllOrder") forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setImage:_rightItem forState:UIControlStateNormal];
    _rightFont = [rightButton.titleLabel font];
    [rightButton addTarget:self action:@selector(rightItem:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setHidden:YES];
    _rightButton = rightButton;
    UIBarButtonItem *rightNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [navigationItem setRightBarButtonItem:rightNavigationItem];
    
    [self pushNavigationItem:navigationItem animated:NO];
    self.navigationItem = navigationItem;
    _rightType = eSearchType;
    
    CGSize titleSize = rightButton.titleLabel.bounds.size;
    CGSize imageSize = rightButton.imageView.bounds.size; //分别设置偏移量:记住偏移量是位移
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30*3/*titleSize.width*/, 0, -titleSize.width);
}

- (void)setNaviBackgroundColor:(UIColor *)color {
    self.barStyle = UIBarStyleBlackTranslucent;
    UIImage *image = [UIImage createImageWithColor:color];
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)rightItem:(UIButton *)button {
    if (_hzDelegate && [_hzDelegate respondsToSelector:@selector(rightItem)]) {
        [_hzDelegate rightItem];
    }
}

- (void)backItem:(UIButton *)button {
    if (_hzDelegate && [_hzDelegate respondsToSelector:@selector(backItem)]) {
        [_hzDelegate backItem];
    }
}


- (void)setShowBackItem:(BOOL)bShow title:(NSString *)title {
    if (_backButton) {
        [_backButton setHidden:!bShow];
    }
    
    if (self.navigationItem) {
        [self.navigationItem setTitle:title];
    }
}

- (void)showSearch:(BOOL)bShow {
    if (_rightButton) {
        
        if (_rightType == eSearchType) {
            [_rightButton setHidden:bShow];
        }
        else
        {
            [_rightButton setHidden:bShow];
            CGRect rect = _rightButton.frame;
            _rightButton.frame = CGRectMake(rect.origin.x, rect.origin.y, NAVIGATIONBAR_HEIGHT * 1.2, NAVIGATIONBAR_HEIGHT);
            [_rightButton setTitle:LOCALIZEDSTRING(@"menuAllOrder") forState:UIControlStateNormal];
            [_rightButton setImage:_rightItem forState:UIControlStateNormal];
            [_rightButton.titleLabel setFont:_rightFont];
            
            _rightType = eSearchType;
        }
    }
}

- (void)showRightNavi:(BOOL)bShow title:(NSString *)title {
    if (_rightButton) {
        if (_rightType == eSearchType) {
            [_rightButton setHidden:!bShow];
            if (_rbRect.origin.x == 0) {
                _rbRect = _rightButton.frame;
                _rightButton.frame = CGRectMake(_rbRect.origin.x, _rbRect.origin.y, CGRectGetWidth(_rbRect) * 2, CGRectGetHeight(_rbRect));
            }


            [_rightButton setTitle:title forState:UIControlStateNormal];
//            [_rightButton setImage:_rightItem forState:UIControlStateNormal];
//            [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
//            _rightType = eCommonType;
        }
        else
        {
            [_rightButton setHidden:!bShow];
        }
    }
}

@end
