//
//  AssignOrderViewController.m
//  MHLogistics
//
//  Created by wjc on 10/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "AssignOrderViewController.h"
#import "HomeCell.h"
#import "HomeData.h"
#import "AssignCell.h"
#import "UIImage+Color.h"
#import "AssignVehicleViewController.h"

CGFloat kSendBtnHeight = 60;

@interface AssignOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIButton *sendBtn;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *confirmDataArray;
@property (nonatomic, strong) NSArray *assignArray;
@property (nonatomic, strong) NSArray *assignDataArray;
@end

@implementation AssignOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _confirmDataArray = @[LOCALIZEDSTRING(@"assignSingleNumber"), LOCALIZEDSTRING(@"assignSeamLess"), LOCALIZEDSTRING(@"assignSeamLess"), LOCALIZEDSTRING(@"assignSeamLess"), LOCALIZEDSTRING(@"assignSeamLess")];
    _assignArray = @[LOCALIZEDSTRING(@"assignVehicle"), LOCALIZEDSTRING(@"assignDerrivrHK"), LOCALIZEDSTRING(@"assignHorseMan")];
    _assignDataArray = @[@"UV2837",@"UV2837",@"UV2837"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sendBtn];
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kSendBtnHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        tableView.separatorInset = UIEdgeInsetsZero;
    }
    _tableView = tableView;
    
    return _tableView;
    
}

- (UIButton *)sendBtn {
    if (_sendBtn) {
        return _sendBtn;
    }
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, kScreenHeight - kSendBtnHeight, kScreenWidth - 40*2, 40)];
    [sendBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [sendBtn setTitle:LOCALIZEDSTRING(@"assignSend") forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendBtn.layer.cornerRadius = 20;
    sendBtn.layer.masksToBounds = YES;

    _sendBtn = sendBtn;
    return sendBtn;
}

- (void)sendAction:(UIButton *)btn {
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:YES title:LOCALIZEDSTRING(@"assignOrder")];
    [self hideSearch];
}

#pragma mark
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return 30;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, kScreenWidth, 30)];
        NSString *sectionTitle = section == 1 ? LOCALIZEDSTRING(@"searchInfo") : LOCALIZEDSTRING(@"assignOrderHeader");
        sectionLabel.text = sectionTitle;
        sectionLabel.font = [UIFont systemFontOfSize:15.0];
        sectionLabel.textColor = [UIColor blackColor];
        return sectionLabel;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if (indexPath.section == 0) {
        height = kHCHeight - 40;
    }
    else if (indexPath.section == 1) {
        height = kHCHeight - 40;
    }
    else if (indexPath.section == 2) {
        height = 50;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
        {
            NSInteger row = indexPath.row;
            if (row == 0) {
                AssignVehicleViewController *avVC  = [[AssignVehicleViewController alloc] init];
                avVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:avVC animated:YES];
            }
        }
            break;

            
        default:
            break;
    }
}

#pragma mark
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
        {

            HomeCell *cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeCell" bottom:NO];

            cell.idxP = indexPath;
            HomeData *hd = self.hd;
            cell.licensePlateLabel.text = hd.licenseP;
            cell.distanceLabel.text = hd.distance;
            cell.timeLabel.text = hd.timeNow;
            cell.tonLabel.text = hd.ton;
            cell.loadingTimeLabel.text = hd.loading;
            cell.clearanceLabel.text = hd.clearance;
            cell.moneyLabel.text = hd.money;
            cell.loadingAddressLabel.text = hd.loadingAddress;
            cell.dischargeLabel.text = hd.unloadAddress;
            for (NSInteger i = 0; i < hd.typeResArray.count; i++) {
                UIImageView *iv = (UIImageView *)cell.imageViewArray[i];
                if (iv) {
                    [iv setImage:hd.typeResArray[i]];
                }
            }
            return cell;
        }
        case 1:
        {
            AssignCell *cell = [[AssignCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AssignCell"];
            cell.singLabel.text = _confirmDataArray[0];
            cell.seamlessLabel.text = _confirmDataArray[1];
            cell.weighLabel.text = _confirmDataArray[2];
            cell.numberLabel.text = _confirmDataArray[3];
            cell.numberTLabel.text = _confirmDataArray[4];
            return cell;
        }
        case 2:
        {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCellStyleValue1"];
            cell.textLabel.text =_assignArray[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.text = _assignDataArray[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        default:
            break;
    }
    
    
    return cell;
}

@end
