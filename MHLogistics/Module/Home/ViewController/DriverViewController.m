//
//  DriverViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "DriverViewController.h"
#import "DriverCell.h"

NSString *const kDriverCell = @"DriverCell";
CGFloat kHeaderHeight = 50.0;

@interface DriverViewController ()<UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UIView *selectedLineView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, weak) NSMutableArray *titleLabelArray;
@property (nonatomic, assign) NSUInteger titleIdx;
@property (nonatomic, assign) CGFloat startContentOffsetX;
@property (nonatomic, assign) CGFloat willEndContentOffsetX;
@property (nonatomic, assign) CGFloat endContentOffsetX;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) NSMutableArray *todayArr;      //今天
@property (nonatomic, weak) NSMutableArray *reservationsArr;//预约
@end


@implementation DriverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _titleArray = @[LOCALIZEDSTRING(@"today"), LOCALIZEDSTRING(@"reserve")];
    _titleIdx = 0;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.scrollView];
}

- (UIView *)scrollView {
    if (_scrollView) {
        return _scrollView;
    }
    
    CGFloat height = self.view.frame.size.height - kHeaderHeight;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeaderHeight, kScreenWidth, height)];
    [scrollView setDelegate:self];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setAlwaysBounceHorizontal:YES];
    [scrollView setScrollEnabled:YES];
    [scrollView setPagingEnabled:YES];
    [scrollView setContentSize:CGSizeMake(kScreenWidth*_titleArray.count, height)];
    for (NSUInteger i = 0; i < _titleArray.count; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, height)];
        tableView.tag = i;
        [scrollView addSubview:tableView];
        tableView.tag = i;
    }
    
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    return scrollView;
}

- (UIView *)headerView {
    if (_headerView) {
        return _headerView;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeaderHeight)];
    headerView.backgroundColor = GrayColor;
    [self.view addSubview:headerView];
    _headerView = headerView;
    
    [self addTitleLabel];
    [headerView addSubview:self.selectedLineView];
    return headerView;
}

- (void)addTitleLabel {
    if (!_headerView) {
        return;
    }
    _titleLabelArray = [NSMutableArray arrayWithCapacity:_titleArray.count];
    CGFloat width = kScreenWidth/_titleArray.count;
    for (NSUInteger i = 0; i < _titleArray.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*width, 0, width, kHeaderHeight)];
        label.tag = i;
        UIColor *color = _titleIdx == i ? MainColor : [UIColor blackColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleTap:)];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tapGesture];
        label.backgroundColor = color;
        label.text = _titleArray[i];
        [_headerView addSubview:label];
        [_titleLabelArray addObject:label];
    }
}

- (UIView *)selectedLineView {
    if (_selectedLineView) {
        return _selectedLineView;
    }
    CGFloat width = kScreenWidth/_titleArray.count;
    UIView *selectedLineView = [[UIView alloc] initWithFrame:CGRectMake(_titleIdx*width, _headerView.frame.size.height - 1, width, 1.0)];
    selectedLineView.backgroundColor = [UIColor redColor];
    _selectedLineView = selectedLineView;
    return selectedLineView;
}

- (void)titleTap:(UIGestureRecognizer *)gesture {
    
    UILabel *label = (UILabel *)[gesture view];
    NSUInteger tag = label.tag;
    if (_titleIdx == tag) {
        DLog(@"same tag");
        return;
    }

    _titleIdx = tag;
    [self showSelectedTitle:NO];
}

- (void)showSelectedTitle:(BOOL)bScrollView {
    
    for (NSUInteger i = 0; i < _titleLabelArray.count; i++) {
        UILabel *label = _titleLabelArray[i];
        UIColor *color = _titleIdx == i ? MainColor : [UIColor blackColor];
        label.backgroundColor = color;
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        CGFloat width = kScreenWidth/self->_titleArray.count;
        self->_selectedLineView.frame = CGRectMake(self->_titleIdx*width, 0, width, 1.0);
        if (bScrollView) {
            CGPoint offset = self->_scrollView.contentOffset;
            offset.y = 0;
            offset.x = self->_titleIdx*self->_scrollView.frame.size.width;
            self->_scrollView.contentOffset = offset;
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:NO title:LOCALIZEDSTRING(@"loginTitle")];
}

#pragma mark
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DriverCell *cell  = [tableView dequeueReusableCellWithIdentifier:kDriverCell];
    if (!cell) {
        cell = [[DriverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDriverCell];
    }
    
    return cell;
}

#pragma mark
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
        if (_titleIdx > 0) {
            _titleIdx--;
        }
        
    } else if (_endContentOffsetX > _willEndContentOffsetX && _willEndContentOffsetX > _startContentOffsetX) {
        //画面从左往右移动，后一页
        if (_titleIdx < _titleArray.count - 1) {
            _titleIdx++;
        }
    }
    [self showSelectedTitle:YES];
}
@end
