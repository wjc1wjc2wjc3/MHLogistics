//
//  SearchResultTableViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "SearchResultTableViewController.h"

@interface SearchResultTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation SearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    
    CGFloat Y = 0;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Y, kScreenWidth, kScreenHeight - Y) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SearchResultCell"];
    _tableView = tableView;
    
    return _tableView;
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    NSString *result = _searchArray[indexPath.row];
    cell.textLabel.text = result;
    return cell;
}

- (void)setSearchArray:(NSMutableArray *)searchArray {
    _searchArray = searchArray;
    [_tableView reloadData];
}
@end
