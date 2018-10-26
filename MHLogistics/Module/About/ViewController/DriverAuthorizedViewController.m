//
//  DriverAuthorizedViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "DriverAuthorizedViewController.h"
#import "AvatarView.h"
#import "UIImage+Color.h"
#import "UIButton+Extension.h"
#import "AInfoInputViewController.h"

@interface DriverAuthorizedViewController ()

@property (nonatomic, weak)AvatarView *avatarView;
@property (nonatomic, weak)UILabel *driveAuthorizedRuleLabel;
@property (nonatomic, weak) UIButton *saBtn;

@end

@implementation DriverAuthorizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.avatarView];
    [self.view addSubview:self.driveAuthorizedRuleLabel];
    [self.view addSubview:self.saBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:YES title:LOCALIZEDSTRING(@"dopDriverAuthorizedTitle")];
}

- (AvatarView *)avatarView {
    if (_avatarView) {
        return _avatarView;
    }
    
    NSArray *iconArray = @[@"hongkang_driver", @"driver"];
    NSArray *titleArray = @[LOCALIZEDSTRING(@"HKDriverLoginAuthroized"), LOCALIZEDSTRING(@"horsemanAuthroized")];
    UIImage *avatarImage = [UIImage imageNamed:iconArray[0]];
    UIImage *leftImage = [UIImage imageNamed:@"left"];
    CGFloat kWidth = avatarImage.size.width + leftImage.size.width*2;
    CGRect rect = CGRectMake((kScreenWidth-kWidth)*0.5, 100, kWidth, avatarImage.size.height + 40);
    AvatarView *avatarView = [[AvatarView alloc] initWithFrame:rect avatar:iconArray title:titleArray];
    _avatarView = avatarView;
    return avatarView;
}

- (UILabel *)driveAuthorizedRuleLabel {
    if (_driveAuthorizedRuleLabel) {
        return _driveAuthorizedRuleLabel;
    }
    NSString *info = LOCALIZEDSTRING(@"driverAuthorizedRule");
    NSArray *infoArray = [info componentsSeparatedByString:@";"];
    NSMutableString *infoM = [@"" mutableCopy];
    [infoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [infoM appendString:obj];
        if (idx != infoArray.count - 1) {
            [infoM appendString:@"\n\n"];
        }
    }];
    UILabel *driveAuthorizedRuleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, _avatarView.frame.origin.y + CGRectGetHeight(_avatarView.frame) + 10, kScreenWidth - 40*2, 120)];
    driveAuthorizedRuleLabel.font = [UIFont systemFontOfSize:13.0];
    driveAuthorizedRuleLabel.numberOfLines = (infoArray.count-1)*3 + 1;
    driveAuthorizedRuleLabel.text = infoM;
    _driveAuthorizedRuleLabel = driveAuthorizedRuleLabel;
    return driveAuthorizedRuleLabel;
}

- (UIButton *)saBtn {
    if (_saBtn) {
        return _saBtn;
    }
    UIButton *saBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, kScreenHeight - 100, kScreenWidth - 40*2, 40)];
    [saBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [saBtn setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [saBtn setTitle:LOCALIZEDSTRING(@"startAuthorized") forState:UIControlStateNormal];
    [saBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saBtn.layer.cornerRadius = 20;
    saBtn.layer.masksToBounds = YES;
    _saBtn = saBtn;
    return saBtn;
}

- (void)okAction:(UIButton *)btn {
    AInfoInputViewController *aII = [[AInfoInputViewController alloc] init];
    aII.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aII animated:YES];
}

@end
