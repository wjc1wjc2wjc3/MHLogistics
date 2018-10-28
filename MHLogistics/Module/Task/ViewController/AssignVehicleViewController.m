//
//  AssignVehicleViewController.m
//  MHLogistics
//
//  Created by wjc on 10/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "AssignVehicleViewController.h"
#import "VehicleMgrInfo.h"
#import "AssignVehicleCell.h"

@interface AssignVehicleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contentArray;

@end

@implementation AssignVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
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
}

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    
    CGFloat Y = 0;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Y, kScreenWidth, kScreenHeight - Y) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[AssignVehicleCell class] forCellReuseIdentifier:@"AssignVehicleCell"];
    _tableView = tableView;
    
    return _tableView;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:YES title:LOCALIZEDSTRING(@"assignVehicle")];
}

#pragma mark
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAssignVehicleCellHeight;
}

#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AssignVehicleCell *cell = (AssignVehicleCell *)[tableView dequeueReusableCellWithIdentifier:@"AssignVehicleCell"];
    if (!cell) {
        cell = [[AssignVehicleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AssignVehicleCell"];
    }
    VehicleMgrInfo *info = _contentArray[indexPath.row];
    cell.licensePlateLabel.text = info.licensePlate;
    cell.distanceLabel.text = info.distance;
    cell.amountLabel.text = info.amount;
    cell.tLabel.text = info.ton;
    cell.timeLabel.text = info.time;
    return cell;
}



@end
