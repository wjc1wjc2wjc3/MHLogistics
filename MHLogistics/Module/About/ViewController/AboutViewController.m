//
//  AboutViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/23.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "AboutViewController.h"
#import "DispatcherViewController.h"
#import "AboutCell.h"
#import "SettingViewController.h"
#import "DOperationViewController.h"

@interface AboutViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imageArray = @[@"grap_oder_state_con", @"dispatch_active_icon", @"customer_service_con", @"set_icon"];
    _titleArray = @[LOCALIZEDSTRING(@"aboutGrabStatus"), LOCALIZEDSTRING(@"aboutDispatcherOperation"), LOCALIZEDSTRING(@"aboutOnlineService"), LOCALIZEDSTRING(@"aboutSetting")];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[AboutCell class] forCellReuseIdentifier:@"AboutCell"];
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    _tableView = tableView;
    
    return _tableView;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:NO title:LOCALIZEDSTRING(@"me")];
    

}

- (void)showAuthor {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:LOCALIZEDSTRING(@"pleaseAuthenticateFirst") message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    ELockWeakSelf();
    UIAlertAction *ok = [UIAlertAction actionWithTitle:LOCALIZEDSTRING(@"immediateCertification") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf dispatcherView];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:LOCALIZEDSTRING(@"cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [ok setValue:BlueColor forKey:@"_titleTextColor"];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)dispatcherView {
    DispatcherViewController *vc = [[DispatcherViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            [self showAuthor];
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                {
                    DOperationViewController *vc = [[DOperationViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 2:
                {
                    
                }
                    break;
                case 3:
                {
                    SettingViewController *setVC = [[SettingViewController alloc] init];
                    setVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:setVC animated:YES];
                }
                    break;

                default:
                    break;
            }
        }
        default:
            break;
    }
}

#pragma mark
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger row = 0;
    switch (section) {
        case 0:
        {
            row = 1;
        }
            break;
        case 1:
        {
            row = 4;
        }
            break;
        default:
            break;
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    DLog(@"indexPath.section %ld", indexPath.section);
    switch (indexPath.section) {
        case 0:
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HeaderCell"];
            UIImage *image = [UIImage imageNamed:@"def_head"];
            cell.imageView.image = image;
            cell.imageView.layer.cornerRadius = image.size.width*0.5;
            cell.imageView.layer.masksToBounds = YES;
            cell.imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapAction:)];
            [cell.imageView addGestureRecognizer:tapGesture];
            cell.textLabel.text = LOCALIZEDSTRING(@"aboutHeaderTitle");
            cell.detailTextLabel.text = LOCALIZEDSTRING(@"aboutDetailTitle");
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 1:
        {
            AboutCell *aCell = (AboutCell *)[tableView dequeueReusableCellWithIdentifier:@"AboutCell"];
            if (!aCell) {
                aCell = (AboutCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AboutCell"];
            }
            UIImage *image = [UIImage imageNamed:_imageArray[indexPath.row]];
            aCell.imageView.image = image;
            NSString *mainText = _titleArray[indexPath.row];
            aCell.mainLabel.text = mainText;
            if (indexPath.row == 0) {
                aCell.rightLabel.text = LOCALIZEDSTRING(@"grabOperation");
                aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell = aCell;
        }
            break;

        default:
            break;
    }
    
    
    return cell;
}


- (void)headerTapAction:(UITapGestureRecognizer *)gesture {
    
}

@end
