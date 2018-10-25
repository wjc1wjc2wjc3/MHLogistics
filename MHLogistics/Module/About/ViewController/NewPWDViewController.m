//
//  NewPWDViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "NewPWDViewController.h"
#import "UIImage+Color.h"
#import "UIButton+Extension.h"

@interface NewPWDViewController ()

@property (nonatomic, weak) UIView *setPwdView;
@property (nonatomic, weak) UIImageView *setPwdImageView;
@property (nonatomic, weak) UIButton *setPwdBtn;
@property (nonatomic, weak) UITextField *setPwdTF;

@property (nonatomic, weak) UIView *confirmPwdView;
@property (nonatomic, weak) UIImageView *confirmPwdImageView;
@property (nonatomic, weak) UIButton *confirmPwdBtn;
@property (nonatomic, weak) UITextField *confirmPwdTF;

@property (nonatomic, weak) UILabel *modifyPwdInfoLabel;

@property (nonatomic, weak) UIButton *confirmLogin;

@end

@implementation NewPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.setPwdView];
    [self.setPwdView addSubview:self.setPwdImageView];
    [self.setPwdView addSubview:self.setPwdBtn];
    [self.setPwdView addSubview:self.setPwdTF];
    
    [self.view addSubview:self.confirmPwdView];
    [self.confirmPwdView addSubview:self.confirmPwdImageView];
    [self.confirmPwdView addSubview:self.confirmPwdBtn];
    [self.confirmPwdView addSubview:self.confirmPwdTF];
    
    [self.view addSubview:self.modifyPwdInfoLabel];
    
    [self.view addSubview:self.confirmLogin];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:YES title:LOCALIZEDSTRING(@"setNewPWD")];
}

- (UIButton *)confirmLogin {
    if (_confirmLogin) {
        return _confirmLogin;
    }
    UIButton *confirmLogin = [[UIButton alloc] initWithFrame:CGRectMake(40, kScreenHeight - 100, kScreenWidth - 40*2, 40)];
    [confirmLogin addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmLogin setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [confirmLogin setTitle:LOCALIZEDSTRING(@"newPwdConfirmBtnTitle") forState:UIControlStateNormal];
    [confirmLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmLogin.layer.cornerRadius = 20;
    confirmLogin.layer.masksToBounds = YES;
    confirmLogin.enabled = NO;
    _confirmLogin = confirmLogin;
    return confirmLogin;
}

- (void)confirmAction:(UIButton *)btn {
    
}

- (UILabel *)modifyPwdInfoLabel {
    if (_modifyPwdInfoLabel) {
        return _modifyPwdInfoLabel;
    }
    NSString *info = LOCALIZEDSTRING(@"pwdRule");
    NSArray *infoArray = [info componentsSeparatedByString:@";"];
    NSMutableString *infoM = [@"" mutableCopy];
    [infoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [infoM appendString:obj];
        if (idx != infoArray.count - 1) {
            [infoM appendString:@"\n"];
        }
    }];
    UILabel *modifyPwdInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(_confirmPwdView.frame.origin.x, _confirmPwdView.frame.origin.y + CGRectGetHeight(_confirmPwdView.frame) + 10, CGRectGetWidth(_confirmPwdView.frame), 100)];
    modifyPwdInfoLabel.font = [UIFont systemFontOfSize:13.0];
    modifyPwdInfoLabel.numberOfLines = infoArray.count;
    modifyPwdInfoLabel.text = infoM;
    _modifyPwdInfoLabel = modifyPwdInfoLabel;
    return modifyPwdInfoLabel;
}

- (UIImageView *)confirmPwdImageView {
    if (_confirmPwdImageView) {
        return _confirmPwdImageView;
    }
    UIImageView *confirmPwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwd"]];
    confirmPwdImageView.frame = CGRectMake(20, 10, 20, 20);
    _confirmPwdImageView = confirmPwdImageView;
    return confirmPwdImageView;
}

- (UITextField *)confirmPwdTF {
    if (_confirmPwdTF) {
        return _confirmPwdTF;
    }
    CGFloat x = _confirmPwdImageView.frame.origin.x + _confirmPwdImageView.frame.size.width + 5;
    UITextField *confirmPwdTF = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, _confirmPwdBtn.frame.origin.x - 5 - x, 40)];
    confirmPwdTF.secureTextEntry = YES;
    confirmPwdTF.placeholder = LOCALIZEDSTRING(@"newPwdConfirm");
    confirmPwdTF.backgroundColor = [UIColor whiteColor];
    _confirmPwdTF = confirmPwdTF;
    return confirmPwdTF;
}

- (UIButton *)confirmPwdBtn {
    if (_confirmPwdBtn) {
        return _confirmPwdBtn;
    }
    UIButton *confirmPwdBtn = [[UIButton alloc] initWithFrame:CGRectMake(_confirmPwdView.frame.size.width - 40 - 5 - 20, 0, 40, 40)];
    [confirmPwdBtn setImage:[UIImage imageNamed:@"pwd_invisible"] forState:UIControlStateNormal];
    [confirmPwdBtn addTarget:self action:@selector(confirmPwdAction:) forControlEvents:UIControlEventTouchUpInside];
    confirmPwdBtn.bEyeClosed = YES;
    _confirmPwdBtn = confirmPwdBtn;
    return confirmPwdBtn;
}

- (void)confirmPwdAction:(UIButton *)button {
    BOOL bEyeClosed =  button.bEyeClosed;
    bEyeClosed  = !bEyeClosed;
    [_confirmPwdBtn setBEyeClosed:bEyeClosed];
    NSString *iconRes = bEyeClosed ? @"pwd_invisible" : @"pwd_visible";
    [_confirmPwdBtn setImage:[UIImage imageNamed:iconRes] forState:UIControlStateNormal];
    _confirmPwdTF.secureTextEntry = !bEyeClosed;
}

- (UIView *)confirmPwdView {
    if (_confirmPwdView) {
        return _confirmPwdView;
    }
    UIView *confirmPwdView = [[UIView alloc] initWithFrame:CGRectMake(45, _setPwdView.frame.origin.y + _setPwdView.frame.size.height + 20, kScreenWidth-45*2, 40)];
    confirmPwdView.backgroundColor = [UIColor whiteColor];
    confirmPwdView.layer.cornerRadius = 20;
    confirmPwdView.layer.masksToBounds = YES;
    _confirmPwdView = confirmPwdView;
    return confirmPwdView;
}

- (UITextField *)setPwdTF {
    if (_setPwdTF) {
        return _setPwdTF;
    }
    CGFloat x = _setPwdImageView.frame.origin.x + _setPwdImageView.frame.size.width + 5;
    UITextField *setPwdTF = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, _setPwdBtn.frame.origin.x - 5 - x, 40)];
    setPwdTF.secureTextEntry = YES;
    setPwdTF.placeholder = LOCALIZEDSTRING(@"newPwdInput");
    setPwdTF.backgroundColor = [UIColor whiteColor];
    _setPwdTF = setPwdTF;
    return setPwdTF;
}

- (UIButton *)setPwdBtn {
    if (_setPwdBtn) {
        return _setPwdBtn;
    }
    UIButton *setPwdBtn = [[UIButton alloc] initWithFrame:CGRectMake(_setPwdView.frame.size.width - 40 - 5 - 20, 0, 40, 40)];
    [setPwdBtn setImage:[UIImage imageNamed:@"pwd_invisible"] forState:UIControlStateNormal];
    [setPwdBtn addTarget:self action:@selector(setPwdAction:) forControlEvents:UIControlEventTouchUpInside];
    setPwdBtn.bEyeClosed = YES;
    _setPwdBtn = setPwdBtn;
    return setPwdBtn;
}

- (void)setPwdAction:(UIButton *)button {
    BOOL bEyeClosed =  button.bEyeClosed;
    bEyeClosed  = !bEyeClosed;
    [_setPwdBtn setBEyeClosed:bEyeClosed];
    NSString *iconRes = bEyeClosed ? @"pwd_invisible" : @"pwd_visible";
    [_setPwdBtn setImage:[UIImage imageNamed:iconRes] forState:UIControlStateNormal];
    _setPwdTF.secureTextEntry = !bEyeClosed;
}

- (UIImageView *)setPwdImageView {
    if (_setPwdImageView) {
        return _setPwdImageView;
    }
    UIImageView *setPwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwd"]];
    setPwdImageView.frame = CGRectMake(20, 10, 20, 20);
    _setPwdImageView = setPwdImageView;
    return setPwdImageView;
}

- (UIView *)setPwdView {
    if (_setPwdView) {
        return _setPwdView;
    }
    UIView *setPwdView = [[UIView alloc] initWithFrame:CGRectMake(45, 90, kScreenWidth-45*2, 40)];
    setPwdView.backgroundColor = [UIColor whiteColor];
    setPwdView.layer.cornerRadius = 20;
    setPwdView.layer.masksToBounds = YES;
    _setPwdView = setPwdView;
    return setPwdView;
}


@end
