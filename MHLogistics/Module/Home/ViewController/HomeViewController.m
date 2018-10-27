//
//  HomeViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/23.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "HomeViewController.h"
#import "SliderHeaderView.h"


NSString *const kTabbarSelectChange = @"TabbarSelectChange";

@interface HomeViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,weak) SliderHeaderView *shView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.shView];
}

- (SliderHeaderView *)shView {
    if (_shView) {
        return _shView;
    }
    
    _titleArray = @[LOCALIZEDSTRING(@"today"), LOCALIZEDSTRING(@"reserve")];
    _pageArray = [NSMutableArray arrayWithCapacity:_titleArray.count];
    _dataArray = [NSMutableArray array];
    SliderHeaderView *shView = [[SliderHeaderView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, 40) array:_titleArray];
    shView.block = ^(NSUInteger tag) {
        
    };
    _shView = shView;
    
    return _shView;
    
}

- (UIView *)scrollView {
    if (_scrollView) {
        return _scrollView;
    }
    
    CGFloat startY = _shView.frame.origin.y + _shView.frame.size.height;
    CGFloat height = self.view.frame.size.height - startY;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, startY, kScreenWidth, height)];
    [scrollView setDelegate:self];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setAlwaysBounceHorizontal:YES];
    [scrollView setPagingEnabled:YES];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(kScreenWidth*_titleArray.count, height)];
    for (NSUInteger i = 0; i < _titleArray.count; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tag = i;
        [scrollView addSubview:tableView];
        [tableView reloadData];
        [_pageArray addObject:tableView];
    }
    
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    return scrollView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:NO title:LOCALIZEDSTRING(@"zgCardTitle")];

}

#pragma mark
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250.0f;
}

#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;

    
    
    return cell;
}

@end
