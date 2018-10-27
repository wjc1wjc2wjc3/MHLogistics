//
//  HomeViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/23.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "HomeViewController.h"
#import "SliderHeaderView.h"
#import "HomeCell.h"
#import "HomeData.h"
#import "PopMenuModel.h"
#import "MHPopMenuView.h"

NSString *const kTabbarSelectChange = @"TabbarSelectChange";

@interface HomeViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, HomeDelegate>

@property (nonatomic,weak) SliderHeaderView *shView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *pageArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *cardTypeImageArray;
@property (nonatomic, strong) NSArray *menuTitleArray;
@property (nonatomic, assign) NSUInteger menuCurIdx;
@property (nonatomic, strong) NSMutableArray *menuModelArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.shView];
    for (NSUInteger i = 0; i < 20; i++) {
        HomeData *hd = [[HomeData alloc] init];
        hd.licenseP = @"CK12372";
        hd.timeNow = @"今天 08:30";
        hd.distance = @"67KM";
        hd.ton = @"8吨";
        hd.loading = @"上午 10:00";
        hd.clearance = @"深圳福田口岸";
        hd.money = @"3610 HK";
        hd.loadingAddress = @"宝安大道967号";
        hd.unloadAddress = @"新城市广场";
        hd.typeArray = [self randomNumArray];
        [self.dataArray addObject:hd];
    }
    [self.view addSubview:self.scrollView];
}

- (NSMutableArray *)randomNumArray {
    int capacity = arc4random() % 1 + 2;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:capacity];
    for (NSUInteger i = 0; i < capacity; i++) {
        int idx = arc4random() % 5;
        [array addObject:[NSNumber numberWithInt:idx]];
    }
    
    return array;
}

- (NSMutableArray *)cardTypeImageArray {
    if (_cardTypeImageArray) {
        return _cardTypeImageArray;
    }
    
    NSArray *array = @[@"ic_deal_general", @"ic_deal_ordinary", @"ic_deal_outday", @"ic_export", @"ic_import",@"ic_urgent"];
    NSMutableArray *cardTypeImageArray = [NSMutableArray arrayWithCapacity:array.count];
    for (NSInteger i = 0; i < array.count; i++) {
        UIImage *image = [UIImage imageNamed:array[i]];
        [cardTypeImageArray addObject:image];
    }
    _cardTypeImageArray = cardTypeImageArray;
    return _cardTypeImageArray;
}

- (NSMutableArray *)dataArray {
    if (_dataArray) {
        return _dataArray;
    }
    
    NSMutableArray *dataArray = [NSMutableArray array];
    _dataArray = dataArray;
    return dataArray;
}

- (SliderHeaderView *)shView {
    if (_shView) {
        return _shView;
    }
    
    _titleArray = @[LOCALIZEDSTRING(@"today"), LOCALIZEDSTRING(@"reserve")];
    _pageArray = [NSMutableArray arrayWithCapacity:_titleArray.count];

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
        [tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tag = i;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    _menuTitleArray = @[LOCALIZEDSTRING(@"menuAllOrder"),LOCALIZEDSTRING(@"menuExport"),LOCALIZEDSTRING(@"menuImport"),LOCALIZEDSTRING(@"menuIgnore")];
    _menuCurIdx = 0;
    NSString *menuTitle = _menuTitleArray[_menuCurIdx];
    [self showRightNavi:YES title:menuTitle block:^{
        [self showMenuSelect];
    }];
}

- (NSMutableArray *)menuModelArray {
    if (_menuModelArray) {
        return _menuModelArray;
    }
    
    NSUInteger count = _menuTitleArray.count;
    NSMutableArray *menuModelArray = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; i++) {
        PopMenuModel *model = [[PopMenuModel alloc] init];
        model.title = _menuTitleArray[i];
        [menuModelArray addObject:model];
    }
    _menuModelArray = menuModelArray;
    
    return menuModelArray;
    
}

- (void)showMenuSelect {
    [MHPopMenuView popWithDataArray:self.menuModelArray width:120 triangleLocation:CGPointMake(kScreenWidth-30, 60) action:^(NSInteger selectedIndex, PopMenuModel *model) {
        self->_menuCurIdx = selectedIndex;
        [self setRightNaviTitle:model.title];
    }];
}

#pragma mark
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kHCHeight;
}

#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    if (!cell) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeCell"];
    }
    cell.idxP = indexPath;
    cell.delegate = self;
    HomeData *hd = _dataArray[indexPath.row];
    cell.licensePlateLabel.text = hd.licenseP;
    cell.distanceLabel.text = hd.distance;
    cell.timeLabel.text = hd.timeNow;
    cell.tonLabel.text = hd.ton;
    cell.loadingTimeLabel.text = hd.loading;
    cell.clearanceLabel.text = hd.clearance;
    cell.moneyLabel.text = hd.money;
    cell.loadingAddressLabel.text = hd.loadingAddress;
    cell.dischargeLabel.text = hd.unloadAddress;
    for (NSInteger i = 0; i < hd.typeArray.count; i++) {
        NSNumber *number = hd.typeArray[i];
        NSInteger idx = number.integerValue;
        UIImage *image = (UIImage *)self.cardTypeImageArray[idx];
        UIImageView *iv = (UIImageView *)cell.imageViewArray[i];
        if (iv) {
            [iv setImage:image];
        }
    }
    return cell;
}

#pragma mark
#pragma mark HomeDelegate
- (void)ignoreOP:(NSIndexPath*)idxP {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"" message:LOCALIZEDSTRING(@"ignoreTitle") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:LOCALIZEDSTRING(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:LOCALIZEDSTRING(@"cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [vc addAction:okAction];
    [vc addAction:cancelAction];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)grapOrderOP:(NSIndexPath *)idxP {
    
}

@end
