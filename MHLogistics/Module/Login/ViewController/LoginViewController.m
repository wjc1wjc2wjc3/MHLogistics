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

@interface LoginViewController ()<LoginDropDownDelegate> {
    NSString *_phonePrefix;
}

@property (nonatomic, weak) UIView *phoneView;
@property (nonatomic, weak) UIImageView *phoneImageView;
@property (nonatomic, weak) UILabel *phonePrefixLabel;
@property (nonatomic, weak) LoginDropDown *phonePrefixDropDown;
@property (nonatomic, weak) UIView *phoneLineView;
@property (nonatomic, weak) UITextField *phoneTF;
@property (nonatomic, weak) UIImageView *phoneErrorImageView;

@property (nonatomic, weak) UIView *pwdView;
@property (nonatomic, weak) UIImageView *pwdImageView;
@property (nonatomic, weak) UITextField *pwdTF;
@property (nonatomic, weak) UIButton *eyeCloseBtn;

@property (nonatomic, weak) UIButton *registerBtn;
@property (nonatomic, weak) UIButton *forgetBtn;

@property (nonatomic, weak) UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:GrayColor];
    
    [self.view addSubview:self.phoneView];
    [self.phoneView addSubview:self.phoneImageView];
    [self.phoneView addSubview:self.phonePrefixLabel];
    [self.phoneView addSubview:self.phoneLineView];
    [self.phoneView addSubview:self.phoneTF];
    [self.phoneView addSubview:self.phoneErrorImageView];
    
    [self.view addSubview:self.pwdView];
    [self.pwdView addSubview:self.pwdImageView];
    [self.pwdView addSubview:self.pwdTF];
    [self.pwdView addSubview:self.eyeCloseBtn];
    
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.loginBtn];
}

- (UIImageView *)phoneImageView {
    UIImageView *phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    phoneImageView.frame = CGRectMake(0, 0, 40, 40);
    _phoneImageView = phoneImageView;
    return phoneImageView;
}

- (UITextField *)phoneTF {
    UITextField *phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, 100, 40)];
    phoneTF.frame = CGRectMake(0, 0, 40, 40);
    phoneTF.backgroundColor = [UIColor whiteColor];
    _phoneTF = phoneTF;
    return phoneTF;
}


- (UIView *)phoneLineView {
    UIView *phoneLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
    phoneLineView.backgroundColor = [UIColor whiteColor];
    _phoneView = phoneLineView;
    return phoneLineView;
}

- (UILabel *)phonePrefixLabel {
    UILabel *phonePrefixLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    phonePrefixLabel.textColor = BlueColor;
    phonePrefixLabel.text = @"+86";
    _phonePrefixLabel = phonePrefixLabel;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [phonePrefixLabel addGestureRecognizer:tapGesture];
    return phonePrefixLabel;
}

- (UIImageView *)phoneErrorImageView {
    UIImageView *phoneErrorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _phoneErrorImageView = phoneErrorImageView;
//    phoneErrorImageView.hidden = YES;
    return phoneErrorImageView;
}

- (void)tapAction:(UITapGestureRecognizer *)gesture {
    DLog(@"");
    CGRect phonePrefixRect = _phonePrefixLabel.frame;
    CGRect dropFrame = CGRectMake(phonePrefixRect.origin.x, phonePrefixRect.origin.y, 40, 80);
    if (!_phonePrefixDropDown) {
        
        LoginDropDown *phonePrefixDropDown = [[LoginDropDown alloc] initWithFrame:dropFrame];
        UITableView *tableView = phonePrefixDropDown.utv;
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        phonePrefixDropDown.delegate = self;
        [self.view addSubview:phonePrefixDropDown];
        _phonePrefixDropDown = phonePrefixDropDown;
    }
    
    if (_phonePrefixDropDown.hidden){
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:2];
        [array addObject:@"86"];
        [array addObject:@"852"];
        [_phonePrefixDropDown setTableArray:array];
        [_phonePrefixDropDown.utv reloadData];
        [self.view bringSubviewToFront:_phonePrefixDropDown];
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [_phonePrefixDropDown setHidden:NO];
        [UIView commitAnimations];
        
    }else{
        [_phonePrefixDropDown setHidden:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_phonePrefixDropDown.isHidden == NO) {
        _phonePrefixDropDown.hidden = YES;
    }
}

- (UIView *)phoneView {
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 306, kScreenWidth-30*2, 60)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.cornerRadius = 20;
    phoneView.layer.masksToBounds = YES;
    _phoneView = phoneView;
    return phoneView;
}

- (UIImageView *)pwdImageView {
    UIImageView *pwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    pwdImageView.frame = CGRectMake(0, 0, 40, 40);
    _pwdImageView = pwdImageView;
    return pwdImageView;
}

- (UITextField *)pwdTF {
    UITextField *pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, 100, 40)];
    pwdTF.frame = CGRectMake(0, 0, 40, 40);
    pwdTF.secureTextEntry = YES;
    pwdTF.backgroundColor = [UIColor whiteColor];
    _pwdTF = pwdTF;
    return pwdTF;
}

- (UIButton *)eyeCloseBtn {
    UIButton *eyeCloseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [eyeCloseBtn addTarget:self action:@selector(eyeCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    eyeCloseBtn.bEyeClosed = YES;
    _eyeCloseBtn = eyeCloseBtn;
    return eyeCloseBtn;
}

- (void)eyeCloseAction:(UIButton *)button {
    DLog(@"showPwdAction");
}

- (UIView *)pwdView {
    UIView *pwdView = [[UIView alloc] initWithFrame:CGRectMake(0, 364, kScreenWidth-30*2, 60)];
    pwdView.backgroundColor = [UIColor whiteColor];
    pwdView.layer.cornerRadius = 20;
    pwdView.layer.masksToBounds = YES;
    _pwdView = pwdView;
    return pwdView;
}

- (UIButton *)registerBtn {
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
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
}

- (UIButton *)forgetBtn {
    UIButton *forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [forgetBtn addTarget:self action:@selector(forget:) forControlEvents:UIControlEventTouchUpInside];
    [forgetBtn setTitle:LOCALIZEDSTRING(@"forgetPwd") forState:UIControlStateNormal];
    [forgetBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    _forgetBtn = forgetBtn;
    return forgetBtn;
}

- (void)forget:(UIButton *)button {
    DLog(@"forget");
}

- (UIButton *)loginBtn {
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - 100, kScreenWidth - 40*2, 40)];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [loginBtn setTitle:LOCALIZEDSTRING(@"loginButton") forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 20;
    loginBtn.layer.masksToBounds = YES;
    _loginBtn = loginBtn;
    return loginBtn;
}

- (void)login:(UIButton *)button {
    DLog(@"login");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:NO title:LOCALIZEDSTRING(@"loginTitle")];
}

#pragma mark
#pragma mark - LoginDropDownDelegate
- (void)clickRow:(NSString *)account{
    _phonePrefix = account;
    [_phonePrefixLabel setText:account];
}

- (void)deleteRow:(NSString *)account{
    [_phonePrefixDropDown setHidden:YES];
}


@end
