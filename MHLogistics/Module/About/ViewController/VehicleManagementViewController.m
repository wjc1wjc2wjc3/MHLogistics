//
//  VehicleManagementViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VehicleManagementViewController.h"
#import "VehicleManageCell.h"
#import "VehicleMgrInfo.h"
#import "SearchResultTableViewController.h"

CGFloat kVehicleManagementCellHeight = 140.0f;

@interface VehicleManagementViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, weak) UISearchController *searchController;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) NSMutableArray *searchArray;
@end

@implementation VehicleManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];

    _searchArray = [NSMutableArray array];
    _contentArray = [NSMutableArray arrayWithCapacity:20];
    for (NSUInteger i = 0; i < 20; i++) {
        VehicleMgrInfo *info = [[VehicleMgrInfo alloc] init];
        info.licensePlate = @"香港车牌:GV287a港";
        info.distance = @"20KM";
        info.amount = @"0000";
        info.ton = @"吨位:20吨";
        info.time = @"添加时间:2018-10-23";
        [_contentArray addObject:info];
    }
    [self.tableView reloadData];
    self.definesPresentationContext = YES;
}

- (UISearchController *)searchController {
    if (_searchController) {
        return _searchController;
    }
    
    SearchResultTableViewController *result = [[SearchResultTableViewController alloc] init];
    UISearchController *searchController = [[UISearchController alloc]initWithSearchResultsController:result];
    searchController.delegate = self;
    searchController.searchResultsUpdater  = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    if (@available(iOS 9.1, *)) {
        searchController.obscuresBackgroundDuringPresentation = NO;
    } else {
        // Fallback on earlier versions
    }
    searchController.hidesNavigationBarDuringPresentation = NO;
    searchController.searchBar.frame = CGRectMake(0, 0, kScreenWidth, 44.0);
    searchController.searchBar.placeholder = LOCALIZEDSTRING(@"search");
    searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchController.searchBar.barTintColor = [UIColor whiteColor];
    searchController.searchBar.delegate = self;
    _searchController = searchController;
    return searchController;
}

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    
    CGFloat Y = 0;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Y, kScreenWidth, kScreenHeight - Y) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[VehicleManageCell class] forCellReuseIdentifier:@"VehicleManageCell"];
    tableView.tableHeaderView = self.searchController.searchBar;
    _tableView = tableView;
    
    return _tableView;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:YES title:LOCALIZEDSTRING(@"dopCarVCAuthorized")];
}

#pragma mark
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kVehicleManagementCellHeight;
}

#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VehicleManageCell *cell = (VehicleManageCell *)[tableView dequeueReusableCellWithIdentifier:@"VehicleManageCell"];
    if (!cell) {
        cell = [[VehicleManageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VehicleManageCell"];
    }
    VehicleMgrInfo *info = _contentArray[indexPath.row];
    cell.licensePlateLabel.text = info.licensePlate;
    cell.distanceLabel.text = info.distance;
    cell.amountLabel.text = info.amount;
    cell.tLabel.text = info.ton;
    cell.timeLabel.text = info.time;
    return cell;
}

#pragma mark
#pragma mark UISearchControllerDelegate
- (void)didPresentSearchController:(UISearchController *)searchController {
    
}

#pragma mark
#pragma mark UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSLog(@"updateSearchResultsForSearchController");
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (!_searchArray) {
        [_searchArray removeAllObjects];
    }
    
    _searchArray = [NSMutableArray arrayWithArray:[_contentArray filteredArrayUsingPredicate:preicate]];
    SearchResultTableViewController *vc = (SearchResultTableViewController *)_searchController.searchResultsController;
    [vc setSearchArray:_searchArray];
}

#pragma mark
#pragma mark UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    DLog(@"searchBarTextDidEndEditing");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
      DLog(@"searchBarTextDidEndEditing");
}


@end
