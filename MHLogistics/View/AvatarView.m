//
//  AvatarView.m
//  MHLogistics
//
//  Created by Apple on 2018/10/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "AvatarView.h"

CGFloat kAvatarSideLen = 123.0;

@interface AvatarView ()<UIScrollViewDelegate>

@property (nonatomic, strong)NSArray *avatarArr;
@property (nonatomic, strong)NSArray *titleArray;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *leftImageView;
@property (nonatomic, weak) UIImageView *rightImageView;
@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) CGFloat startContentOffsetX;
@property (nonatomic, assign) CGFloat willEndContentOffsetX;
@property (nonatomic, assign) CGFloat endContentOffsetX;
@end

@implementation AvatarView

- (instancetype)initWithFrame:(CGRect)frame avatar:(NSArray *)avatarArr title:(NSArray *)titleArr {
    self = [super initWithFrame:frame];
    if (self) {
        _avatarArr = avatarArr;
        _titleArray =  titleArr;
        _currentPage = 0;
    }
    
    return self;
}

- (void)layoutSubviews {
    
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((kScreenWidth - kAvatarSideLen)/2, 0, (kScreenWidth - kAvatarSideLen)/2, kAvatarSideLen)];
        [scrollView setDelegate:self];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setAlwaysBounceHorizontal:YES];
        [scrollView setScrollEnabled:YES];
        [scrollView setPagingEnabled:YES];
        [scrollView setContentSize:CGSizeMake(kAvatarSideLen*_avatarArr.count, kAvatarSideLen)];
        for (NSUInteger i = 0; i < _avatarArr.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*kAvatarSideLen, 0, kAvatarSideLen, kAvatarSideLen)];
            imageView.image = [UIImage imageNamed:_avatarArr[i]];
            [scrollView addSubview:imageView];
            imageView.tag = i;
        }
        
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    
    
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 45)];
        titleLabel.text = _titleArray[_currentPage];
        [self addSubview:titleLabel];
        _titleLabel =titleLabel;
    }
    
    if (!_leftImageView) {
        UIImage *image = [UIImage imageNamed:@""];
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:image];
        leftImageView.frame = CGRectMake(0, 0, (kScreenWidth - kAvatarSideLen)/2, kAvatarSideLen);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapAction:)];
        [leftImageView addGestureRecognizer:tapGesture];
        [self addSubview:leftImageView];
        _leftImageView = leftImageView;
    }
    
    if (!_rightImageView) {
        UIImage *image = [UIImage imageNamed:@""];
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:image];
        rightImageView.frame = CGRectMake(0, (kScreenWidth + kAvatarSideLen)/2, (kScreenWidth - kAvatarSideLen)/2, kAvatarSideLen);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapAction:)];
        [rightImageView addGestureRecognizer:tapGesture];
        
        [self addSubview:rightImageView];
        _rightImageView = rightImageView;
    }
}

- (void)leftTapAction:(UITapGestureRecognizer *)recognizer {
    [self moveAvatar:YES];
}

- (void)rightTapAction:(UITapGestureRecognizer *)recognizer {
    [self moveAvatar:NO];
}

- (void)moveAvatar:(BOOL)bLeft {
    if (bLeft && _currentPage == 0) {
        return;
    }
    
    if (!bLeft && _currentPage == _avatarArr.count - 1) {
        return;
    }
    _currentPage = bLeft ? _currentPage-- : _currentPage++;
    _titleLabel.text = _titleArray[_currentPage];
    _scrollView.contentOffset = CGPointMake(_currentPage*kAvatarSideLen, 0);
}

#pragma mark
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    point.y = 0.f;
    scrollView.contentOffset = point;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _startContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    _willEndContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _endContentOffsetX = scrollView.contentOffset.x;
    
    if (_endContentOffsetX < _willEndContentOffsetX && _willEndContentOffsetX < _startContentOffsetX) {
        //画面从右往左移动，前一页
        if (_currentPage > 0) {
            _currentPage--;
        }
        
    } else if (_endContentOffsetX > _willEndContentOffsetX && _willEndContentOffsetX > _startContentOffsetX) {
        //画面从左往右移动，后一页
        if (_currentPage < _avatarArr.count - 1) {
            _currentPage++;
        }
    }
    
    _titleLabel.text = _titleArray[_currentPage];
    if (_delegate && [_delegate respondsToSelector:@selector(avatarSeleted:)]) {
        [_delegate avatarSeleted:_currentPage];
    }
}

@end
