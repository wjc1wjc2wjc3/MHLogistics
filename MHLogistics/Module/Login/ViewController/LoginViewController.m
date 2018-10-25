//
//  LoginViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/23.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "LoginViewController.h"
#import "UIImage+Color.h"
#import "UIButton+Extension.h"
#import "LoginDropDown.h"
#import "AvatarView.h"
#import "HZBitPopupView.h"
#import "CountDownButton.h"

@interface LoginViewController ()<UITextFieldDelegate> {
    NSString *_phonePrefix;
}

@property (nonatomic, weak) AvatarView *avatarView;
@property (nonatomic, weak) UIView *phoneView;
@property (nonatomic, weak) UIImageView *phoneImageView;
@property (nonatomic, weak) UILabel *phonePrefixLabel;
@property (nonatomic, weak) UIView *phoneLineView;
@property (nonatomic, weak) UITextField *phoneTF;
@property (nonatomic, weak) UIImageView *phoneErrorImageView;


@property (nonatomic, weak) UIButton *registerBtn;
@property (nonatomic, weak) UIButton *forgetBtn;
@property (nonatomic, weak) UIButton *loginBtn;
//注册
@property (nonatomic, weak) UIView *verifyView;
@property (nonatomic, weak) UIImageView *verifyImageView;
@property (nonatomic, weak) UIView *verifyLineView;
@property (nonatomic, weak) CountDownButton *verifyBtn;
@property (nonatomic, weak) UITextField *verifyTF;
@property (nonatomic, weak) UIButton *nextBtn;

//登录
@property (nonatomic, weak) UIView *pwdView;
@property (nonatomic, weak) UIImageView *pwdImageView;
@property (nonatomic, weak) UIButton *eyeCloseBtn;
@property (nonatomic, weak) UITextField *pwdTF;


//忘记密码
@property (nonatomic, weak) UILabel *modifyLabel;

@property (nonatomic, weak) UIView *setPwdView;
@property (nonatomic, weak) UIImageView *setPwdImageView;
@property (nonatomic, weak) UIButton *setPwdBtn;
@property (nonatomic, weak) UITextField *setPwdTF;

@property (nonatomic, weak) UIView *confirmPwdView;
@property (nonatomic, weak) UIImageView *confirmPwdImageView;
@property (nonatomic, weak) UIButton *confirmPwdBtn;
@property (nonatomic, weak) UITextField *confirmPwdTF;

@property (nonatomic, weak) UILabel *modifyPwdInfoLabel;
@property (nonatomic, weak) UIButton *okBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:GrayColor];
    [self.view addSubview:self.avatarView];

}

- (void)initUI {
    switch (self.vcType) {
        case eLogin:
            [self loginUI];
            break;
        case eRegister:
            [self registerUI];
            break;
        case eModifyPwd:
            [self modifyPWDUI];
            break;

        default:
            break;
    }
}

- (void)registerUI {
    [self.view addSubview:self.phoneView];
    [self.phoneView addSubview:self.phoneImageView];
    [self.phoneView addSubview:self.phonePrefixLabel];
    [self.phoneView addSubview:self.phoneLineView];
    [self.phoneView addSubview:self.phoneErrorImageView];
    [self.phoneView addSubview:self.phoneTF];
    
    [self.view addSubview:self.verifyView];
    [self.verifyView addSubview:self.verifyImageView];
    [self.verifyView addSubview:self.verifyBtn];
    [self.verifyView addSubview:self.verifyLineView];
    [self.verifyView addSubview:self.verifyTF];
    
    [self.view addSubview:self.nextBtn];
}

- (void)modifyPWDUI {
    
//    [self.view addSubview:self.modifyLabel];
    
    [self.view addSubview:self.setPwdView];
    [self.setPwdView addSubview:self.setPwdImageView];
    [self.setPwdView addSubview:self.setPwdBtn];
    [self.setPwdView addSubview:self.setPwdTF];
    
    [self.view addSubview:self.confirmPwdView];
    [self.confirmPwdView addSubview:self.confirmPwdImageView];
    [self.confirmPwdView addSubview:self.confirmPwdBtn];
    [self.confirmPwdView addSubview:self.confirmPwdTF];
    
    [self.view addSubview:self.modifyPwdInfoLabel];
    
    [self.view addSubview:self.okBtn];
}

- (UILabel *)modifyLabel {
    if (_modifyLabel) {
        return _modifyLabel;
    }
    NSString *info = LOCALIZEDSTRING(@"modifyPwd");
    UILabel *modifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avatarView.frame.origin.x, _avatarView.frame.origin.y + CGRectGetHeight(_avatarView.frame) + 10, CGRectGetWidth(_avatarView.frame), 100)];
    modifyLabel.font = [UIFont systemFontOfSize:13.0];
    modifyLabel.numberOfLines = 2;
    modifyLabel.text = info;
    _modifyLabel = modifyLabel;
    return modifyLabel;
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
    confirmPwdTF.placeholder = LOCALIZEDSTRING(@"confirmPwd");
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
    setPwdTF.placeholder = LOCALIZEDSTRING(@"setPwd");
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
    UIView *setPwdView = [[UIView alloc] initWithFrame:CGRectMake(45, _avatarView.frame.origin.y + _avatarView.frame.size.height + 40, kScreenWidth-45*2, 40)];
    setPwdView.backgroundColor = [UIColor whiteColor];
    setPwdView.layer.cornerRadius = 20;
    setPwdView.layer.masksToBounds = YES;
    _setPwdView = setPwdView;
    return setPwdView;
}

- (UIButton *)okBtn {
    if (_okBtn) {
        return _okBtn;
    }
    UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, kScreenHeight - 100, kScreenWidth - 40*2, 40)];
    [okBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [okBtn setTitle:LOCALIZEDSTRING(@"confirm") forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn.layer.cornerRadius = 20;
    okBtn.layer.masksToBounds = YES;
    _okBtn = okBtn;
    return okBtn;
}

- (void)okAction:(UIButton *)btn {
    
}

- (void)loginUI {
    [self.view addSubview:self.phoneView];
    [self.phoneView addSubview:self.phoneImageView];
    [self.phoneView addSubview:self.phonePrefixLabel];
    [self.phoneView addSubview:self.phoneLineView];
    [self.phoneView addSubview:self.phoneErrorImageView];
    [self.phoneView addSubview:self.phoneTF];
    
    [self.view addSubview:self.pwdView];
    [self.pwdView addSubview:self.pwdImageView];
    [self.pwdView addSubview:self.eyeCloseBtn];
    [self.pwdView addSubview:self.pwdTF];

    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.loginBtn];
}

- (UIButton *)nextBtn {
    if (_nextBtn) {
        return _nextBtn;
    }
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, kScreenHeight - 100, kScreenWidth - 40*2, 40)];
    [nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [nextBtn setTitle:LOCALIZEDSTRING(@"next") forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.layer.masksToBounds = YES;
    _nextBtn = nextBtn;
    return nextBtn;
}

- (void)next:(UIButton *)btn {
    
}

- (UITextField *)verifyTF {
    if (_verifyTF) {
        return _verifyTF;
    }
    CGFloat width = _verifyLineView.frame.origin.x - 5*2-_verifyImageView.frame.origin.x;
    UITextField *verifyTF = [[UITextField alloc] initWithFrame:CGRectMake(_verifyImageView.frame.origin.x + _verifyImageView.frame.size.width + 5, 0, width, 40)];
    verifyTF.placeholder = LOCALIZEDSTRING(@"pleaseInputVerify");
    verifyTF.delegate = self;
    verifyTF.keyboardType = UIKeyboardTypePhonePad;
    verifyTF.backgroundColor = [UIColor whiteColor];
    _verifyTF = verifyTF;
    return verifyTF;
}


- (UIView *)verifyLineView {
    if (_verifyLineView) {
        return _verifyLineView;
    }
    UIView *verifyLineView = [[UIView alloc] initWithFrame:CGRectMake(_verifyBtn.frame.origin.x - 1 - 5, 5, 1, 30)];
    verifyLineView.backgroundColor = GrayColor;
    _verifyLineView = verifyLineView;
    return verifyLineView;
}

- (UIButton *)verifyBtn {
    if (_verifyBtn) {
        return _verifyBtn;
    }
    CGFloat width = 120;
    CountDownButton *verifyBtn = [[CountDownButton alloc] initWithFrame:CGRectMake(_verifyView.frame.size.width - 15 - width, 0, width, 40)];
    [verifyBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
    [verifyBtn addTarget:self action:@selector(smsVerifyAction:) forControlEvents:UIControlEventTouchUpInside];
    [verifyBtn setTitle:LOCALIZEDSTRING(@"getVerify") forState:UIControlStateNormal];
    [verifyBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    _verifyBtn = verifyBtn;
    return verifyBtn;
}

- (IBAction)smsVerifyAction:(CountDownButton *)countDownButton {
    NSString *account = _phoneTF.text;
    if ([account isEqualToString:@""]) {
        [MBManager showBriefAlert:LOCALIZEDSTRING(@"phoneNumberIsSpace")];
        return;
    }
    
    countDownButton.enabled = NO;
    [countDownButton startCountDownWithSecond:VERIFY_CODE_DURATION];
    
    
    [countDownButton countDownChanging:^NSString *(CountDownButton *countDownButton,NSUInteger second) {
        NSString *title = [NSString stringWithFormat:LOCALIZEDSTRING(@"leftSecond"),second];
        return title;
    }];
    [countDownButton countDownFinished:^NSString *(CountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        return LOCALIZEDSTRING(@"clickReget");
    }];
}

- (UIImageView *)verifyImageView {
    if (_verifyImageView) {
        return _verifyImageView;
    }
    UIImageView *verifyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sms_code"]];
    verifyImageView.frame = CGRectMake(20, 10, 20, 20);
    _verifyImageView = verifyImageView;
    return verifyImageView;
}

- (UIView *)verifyView {
    if (_verifyView) {
        return _verifyView;
    }
    UIView *verifyView = [[UIView alloc] initWithFrame:CGRectMake(45, _phoneView.frame.origin.y + _phoneView.frame.size.height + 20, kScreenWidth-45*2, 40)];
    verifyView.backgroundColor = [UIColor whiteColor];
    verifyView.layer.cornerRadius = 20;
    verifyView.layer.masksToBounds = YES;
    _verifyView = verifyView;
    return verifyView;
}

- (AvatarView *)avatarView {
    if (_avatarView) {
        return _avatarView;
    }
    
    NSArray *iconArray = @[@"dispatch", @"employed", @"hongkang_driver", @"driver"];
    NSArray *titleArray = @[LOCALIZEDSTRING(@"dispatcherLogin"), LOCALIZEDSTRING(@"singleHeadDriverLogin"), LOCALIZEDSTRING(@"HKDriverLogin"), LOCALIZEDSTRING(@"horsemanLogin")];
    UIImage *avatarImage = [UIImage imageNamed:iconArray[0]];
    UIImage *leftImage = [UIImage imageNamed:@"left"];
    CGFloat kWidth = avatarImage.size.width + leftImage.size.width*2;
    CGRect rect = CGRectMake((kScreenWidth-kWidth)*0.5, 100, kWidth, avatarImage.size.height + 40);
    AvatarView *avatarView = [[AvatarView alloc] initWithFrame:rect avatar:iconArray title:titleArray];
    _avatarView = avatarView;
    return avatarView;
}

- (UIImageView *)phoneImageView {
    if (_phoneImageView) {
        return _phoneImageView;
    }
    
    UIImageView *phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone"]];
    phoneImageView.frame = CGRectMake(20, 10, 20, 20);
    _phoneImageView = phoneImageView;
    return phoneImageView;
}

- (UITextField *)phoneTF {
    if (_phoneTF) {
        return _phoneTF;
    }
    CGFloat width = _phoneErrorImageView.frame.origin.x - 5*2-_phoneLineView.frame.origin.x -_phoneLineView.frame.size.width;
    UITextField *phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(_phoneLineView.frame.origin.x + _phoneLineView.frame.size.width + 5, 0, width, 40)];
    phoneTF.placeholder = LOCALIZEDSTRING(@"phonePlacer");
    phoneTF.delegate = self;
    phoneTF.keyboardType = UIKeyboardTypePhonePad;
    phoneTF.backgroundColor = [UIColor whiteColor];
    _phoneTF = phoneTF;
    return phoneTF;
}


- (UIView *)phoneLineView {
    if (_phoneLineView) {
        return _phoneLineView;
    }
    UIView *phoneLineView = [[UIView alloc] initWithFrame:CGRectMake(_phonePrefixLabel.frame.origin.x + _phonePrefixLabel.frame.size.width + 5, 5, 1, 30)];
    phoneLineView.backgroundColor = GrayColor;
    _phoneLineView = phoneLineView;
    return phoneLineView;
}

- (UILabel *)phonePrefixLabel {
    if (_phonePrefixLabel) {
        return _phonePrefixLabel;
    }
    UILabel *phonePrefixLabel = [[UILabel alloc] initWithFrame:CGRectMake(_phoneImageView.frame.origin.x + _phoneImageView.frame.size.width + 5, 0, 40, 40)];
    phonePrefixLabel.textColor = BlueColor;
    phonePrefixLabel.text = @"+86";
    phonePrefixLabel.userInteractionEnabled = YES;
    _phonePrefixLabel = phonePrefixLabel;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [phonePrefixLabel addGestureRecognizer:tapGesture];
    return phonePrefixLabel;
}

- (UIImageView *)phoneErrorImageView {
    if (_phoneErrorImageView) {
        return _phoneErrorImageView;
    }
    UIImageView *phoneErrorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_phoneView.frame.size.width - 40 - 20, 0, 40, 40)];
    phoneErrorImageView.contentMode = UIViewContentModeCenter;
    phoneErrorImageView.image = [UIImage imageNamed:@"error_icon"];
    _phoneErrorImageView = phoneErrorImageView;
//    phoneErrorImageView.hidden = YES;
    return phoneErrorImageView;
}

- (void)tapAction:(UITapGestureRecognizer *)gesture {

    NSArray *phoneArray = @[@"+86", @"852"];
    HZBitPopupView *hzBitPopupView = [[HZBitPopupView alloc] initHZBitPopupView:phoneArray];
    hzBitPopupView.block = ^(NSInteger index) {
        self->_phonePrefix = phoneArray[index];
        self->_phonePrefixLabel.text = self->_phonePrefix;
    };
    [hzBitPopupView show];
}

- (UIView *)phoneView {
    if (_phoneView) {
        return _phoneView;
    }
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(45, _avatarView.frame.origin.y + _avatarView.frame.size.height + 40, kScreenWidth-45*2, 40)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.cornerRadius = 20;
    phoneView.layer.masksToBounds = YES;
    _phoneView = phoneView;
    return phoneView;
}

- (UIImageView *)pwdImageView {
    if (_pwdImageView) {
        return _pwdImageView;
    }
    UIImageView *pwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwd"]];
    pwdImageView.frame = CGRectMake(20, 10, 20, 20);
    _pwdImageView = pwdImageView;
    return pwdImageView;
}

- (UITextField *)pwdTF {
    if (_pwdTF) {
        return _pwdTF;
    }
    CGFloat x = _pwdImageView.frame.origin.x + _pwdImageView.frame.size.width + 5;
    UITextField *pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, _eyeCloseBtn.frame.origin.x - 5 - x, 40)];
    pwdTF.secureTextEntry = YES;
    pwdTF.placeholder = LOCALIZEDSTRING(@"pwdPlacer");
    pwdTF.backgroundColor = [UIColor whiteColor];
    _pwdTF = pwdTF;
    return pwdTF;
}

- (UIButton *)eyeCloseBtn {
    if (_eyeCloseBtn) {
        return _eyeCloseBtn;
    }
    UIButton *eyeCloseBtn = [[UIButton alloc] initWithFrame:CGRectMake(_pwdView.frame.size.width - 40 - 5 - 20, 0, 40, 40)];
    [eyeCloseBtn setImage:[UIImage imageNamed:@"pwd_invisible"] forState:UIControlStateNormal];
    [eyeCloseBtn addTarget:self action:@selector(eyeCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    eyeCloseBtn.bEyeClosed = YES;
    _eyeCloseBtn = eyeCloseBtn;
    return eyeCloseBtn;
}

- (void)eyeCloseAction:(UIButton *)button {
    BOOL bEyeClosed =  button.bEyeClosed;
    bEyeClosed  = !bEyeClosed;
    [_eyeCloseBtn setBEyeClosed:bEyeClosed];
    NSString *iconRes = bEyeClosed ? @"pwd_invisible" : @"pwd_visible";
    [_eyeCloseBtn setImage:[UIImage imageNamed:iconRes] forState:UIControlStateNormal];
    _pwdTF.secureTextEntry = !bEyeClosed;
}

- (UIView *)pwdView {
    if (_pwdView) {
        return _pwdView;
    }
    UIView *pwdView = [[UIView alloc] initWithFrame:CGRectMake(45, _phoneView.frame.origin.y + _phoneView.frame.size.height + 20, kScreenWidth-45*2, 40)];
    pwdView.backgroundColor = [UIColor whiteColor];
    pwdView.layer.cornerRadius = 20;
    pwdView.layer.masksToBounds = YES;
    _pwdView = pwdView;
    return pwdView;
}

- (UIButton *)registerBtn {
    if (_registerBtn) {
        return _registerBtn;
    }
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(_pwdView.frame.origin.x, _pwdView.frame.origin.y + _pwdView.frame.size.height + 10, 80, 40)];
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:LOCALIZEDSTRING(@"register") forState:UIControlStateNormal];
    [registerBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    registerBtn.layer.cornerRadius = 20;
    registerBtn.layer.masksToBounds = YES;
    _registerBtn = registerBtn;
    return registerBtn;
}

- (void)registerAction:(UIButton *)button {
    DLog(@"registerAction");
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.vcType = eRegister;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (UIButton *)forgetBtn {
    if (_forgetBtn) {
        return _forgetBtn;
    }
    UIButton *forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(_pwdView.frame.origin.x + _pwdView.frame.size.width - 80, _registerBtn.frame.origin.y, 80, 40)];
    [forgetBtn addTarget:self action:@selector(forget:) forControlEvents:UIControlEventTouchUpInside];
    [forgetBtn setTitle:LOCALIZEDSTRING(@"forgetPwd") forState:UIControlStateNormal];
    [forgetBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    _forgetBtn = forgetBtn;
    return forgetBtn;
}

- (void)forget:(UIButton *)button {
    DLog(@"forget");
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.vcType = eModifyPwd;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (UIButton *)loginBtn {
    if (_loginBtn) {
        return _loginBtn;
    }
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, kScreenHeight - 100, kScreenWidth - 40*2, 40)];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [loginBtn setTitle:LOCALIZEDSTRING(@"loginButton") forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 20;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.enabled = NO;
    _loginBtn = loginBtn;
    return loginBtn;
}

- (void)login:(UIButton *)button {
    DLog(@"login");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *resId = @"";
    BOOL bShowNaviReturn = NO;
    switch (self.vcType) {
        case eRegister:
        {
            bShowNaviReturn = YES;
            resId = @"accountRegister";
        }
            break;
        case eModifyPwd:
        {
            bShowNaviReturn = YES;
            resId = @"setPWD";
        }
            break;
        case eLogin:
        {
            bShowNaviReturn = NO;
            resId = @"loginTitle";
        }
            break;
        default:
            break;
    }
    [self showNaviBar:bShowNaviReturn title:LOCALIZEDSTRING(resId)];
    [self initUI];
}


#pragma mark
#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 11) {
        _loginBtn.enabled = YES;
    }
}

@end
