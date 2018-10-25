//
//  SettingViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "UIImage+Color.h"
#import "NewPWDViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIButton *exitLogin;

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _titleArray = @[LOCALIZEDSTRING(@"settingNewMessageNotification"), LOCALIZEDSTRING(@"settingLanguageSelected"), LOCALIZEDSTRING(@"setPwdModify"), LOCALIZEDSTRING(@"setIntroduce")];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SettingCell class] forCellReuseIdentifier:@"SettingCell"];
    [self.tableView reloadData];
    [self.view addSubview:self.exitLogin];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:YES title:LOCALIZEDSTRING(@"settingTitle")];
}

- (UIButton *)exitLogin {
    if (_exitLogin) {
        return _exitLogin;
    }
    UIButton *exitLogin = [[UIButton alloc] initWithFrame:CGRectMake(40, kScreenHeight - 100, kScreenWidth - 40*2, 40)];
    [exitLogin addTarget:self action:@selector(exitAction:) forControlEvents:UIControlEventTouchUpInside];
    [exitLogin setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [exitLogin setTitle:LOCALIZEDSTRING(@"exitLogin") forState:UIControlStateNormal];
    [exitLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    exitLogin.layer.cornerRadius = 20;
    exitLogin.layer.masksToBounds = YES;
    exitLogin.enabled = NO;
    _exitLogin = exitLogin;
    return exitLogin;
}

- (void)exitAction:(UIButton *)btn {
    
}

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 100) style:UITableViewStylePlain];
    [self setExtraCellLineHidden:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    _tableView = tableView;
    
    return _tableView;
    
}

#pragma mark
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            NewPWDViewController *vc = [[NewPWDViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {

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

        SettingCell *sCell = (SettingCell *)[tableView dequeueReusableCellWithIdentifier:@"SettingCell"];
        if (!sCell) {
            sCell = (SettingCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SettingCell"];
        }
        NSString *mainText = _titleArray[indexPath.row];
        sCell.mainLabel.text = mainText;
        if (indexPath.row == 0) {
            sCell.rightLabel.text = LOCALIZEDSTRING(@"settingNewMessageNotificationEnabled");
            sCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    
    
    return sCell;
}


@end
