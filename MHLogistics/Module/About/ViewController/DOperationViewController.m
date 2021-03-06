//
//  DOperationViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "DOperationViewController.h"
#import "VehicleCertificationViewController.h"
#import "VehicleManagementViewController.h"
#import "DriverAuthorizedViewController.h"


@interface DOperationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation DOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imageArray = @[@"grap_oder_state_con", @"dispatch_active_icon", @"customer_service_con", @"set_icon"];
    _titleArray = @[LOCALIZEDSTRING(@"dopCarAuthorized"), LOCALIZEDSTRING(@"dopCarMgr"), LOCALIZEDSTRING(@"dopDriverAuthorized"), LOCALIZEDSTRING(@"dopDriverMgr")];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DOPCell"];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:YES title:LOCALIZEDSTRING(@"doperationTitle")];
}

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 100) style:UITableViewStylePlain];
    [self setExtraCellLineHidden:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    _tableView = tableView;
    
    return _tableView;
    
}

#pragma mark
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSetCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            VehicleCertificationViewController *vehicleCVC = [[VehicleCertificationViewController alloc] init];
            vehicleCVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vehicleCVC animated:YES];
        }
            break;
        case 1:
        {
            VehicleManagementViewController *vehicleCVC = [[VehicleManagementViewController alloc] init];
            vehicleCVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vehicleCVC animated:YES];
            
        }
            break;
        case 2:
        {
            DriverAuthorizedViewController *vehicleCVC = [[DriverAuthorizedViewController alloc] init];
            vehicleCVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vehicleCVC animated:YES];
        }
            break;
        case 3:
        {
            VehicleManagementViewController *vehicleCVC = [[VehicleManagementViewController alloc] init];
            vehicleCVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vehicleCVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DOPCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DOPCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *mainText = _titleArray[indexPath.row];
    cell.textLabel.text = mainText;
    cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



@end
