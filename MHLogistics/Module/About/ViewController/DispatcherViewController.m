//
//  DispatcherViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "DispatcherViewController.h"
#import "UIButton+Extension.h"
#import "UIImage+Color.h"

@interface DispatcherViewController ()

@property (nonatomic, weak) UIImageView *headerImageView;
@property (nonatomic, weak) UILabel *introduceLabel;
@property (nonatomic, weak) UIButton *radioBtn;
@property (nonatomic, weak) NSMutableArray<UIImage *> *radioImageArr;

@property (nonatomic, weak) UILabel *agreeLabel;
@property (nonatomic, weak) UILabel *protocolLabel;
@property (nonatomic, weak) UIButton *nextBtn;

@end

@implementation DispatcherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.headerImageView];
    [self.view addSubview:self.introduceLabel];
    [self.view addSubview:self.nextBtn];
    [self.view addSubview:self.radioBtn];
    [self.view addSubview:self.agreeLabel];
    [self.view addSubview:self.protocolLabel];

}

- (UILabel *)agreeLabel {
    if (_agreeLabel) {
        return _agreeLabel;
    }
    
    UILabel *agreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_radioBtn.frame.origin.x + _radioBtn.frame.size.width, _radioBtn.frame.origin.y, 40, 40)];
    agreeLabel.textColor = [UIColor blackColor];
    agreeLabel.text = LOCALIZEDSTRING(@"agree");
    agreeLabel.textAlignment = NSTextAlignmentCenter;
    agreeLabel.font = [UIFont boldSystemFontOfSize:12.0];
    _agreeLabel = agreeLabel;
    
    return _agreeLabel;
    
}


- (UILabel *)protocolLabel {
    if (_protocolLabel) {
        return _protocolLabel;
    }
    
    UILabel *protocolLabel = [[UILabel alloc] initWithFrame:CGRectMake(_agreeLabel.frame.origin.x + _agreeLabel.frame.size.width, _agreeLabel.frame.origin.y, 200, 40)];
    protocolLabel.textColor = BlueColor;
    protocolLabel.text = LOCALIZEDSTRING(@"protocol");
    protocolLabel.textAlignment = NSTextAlignmentLeft;
    protocolLabel.font = [UIFont boldSystemFontOfSize:12.0];
    protocolLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protocolAction:)];
    [protocolLabel addGestureRecognizer:tapGesture];
    _protocolLabel = protocolLabel;
    
    return _protocolLabel;
    
}

- (void)protocolAction:(UITapGestureRecognizer *)gesture {
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:YES title:LOCALIZEDSTRING(@"dispatcherCertification")];
}

- (UIButton *)radioBtn {
    if (_radioBtn) {
        return _radioBtn;
    }
    UIButton *radioBtn = [[UIButton alloc] initWithFrame:CGRectMake(_nextBtn.frame.origin.x, _nextBtn.frame.origin.y - 30 - 40, 40, 40)];
    [radioBtn addTarget:self action:@selector(radioAction:) forControlEvents:UIControlEventTouchUpInside];
    [radioBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    radioBtn.bSelected = NO;
    _radioBtn = radioBtn;
    return radioBtn;
}

- (void)radioAction:(UIButton *)button {
    DLog(@"radioAction");
    BOOL bSelected =  button.bSelected;
    bSelected  = !bSelected;
    [_radioBtn setBSelected:bSelected];
    NSString *iconRes = bSelected ? @"selected" : @"unselected";
    [_radioBtn setImage:[UIImage imageNamed:iconRes] forState:UIControlStateNormal];
    
}

- (UIButton *)nextBtn {
    if (_nextBtn) {
        return _nextBtn;
    }
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, kScreenHeight - 100, kScreenWidth - 40*2, 40)];
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [nextBtn setTitle:LOCALIZEDSTRING(@"next") forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.layer.masksToBounds = YES;
    _nextBtn = nextBtn;
    return nextBtn;
}

- (void)nextAction:(UIButton *)btn {
    
}

- (UILabel *)introduceLabel {
    if (_introduceLabel) {
        return _introduceLabel;
    }
    
    UILabel *introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, _headerImageView.frame.origin.y + CGRectGetHeight(_headerImageView.frame), kScreenWidth- 40*2, 200)];
//    introduceLabel.textColor = [UIColor blackColor];
    NSString *text = LOCALIZEDSTRING(@"authorizedInfo");
    NSArray *array = [text componentsSeparatedByString:@";"];
    NSMutableString *textM = [@"" mutableCopy];
    for (NSUInteger i = 0; i < array.count; i++) {
        [textM appendString:array[i]];
        if (i != array.count - 1) {
            [textM appendString:@"\n\n"];
        }
    }
    introduceLabel.text = textM;
    introduceLabel.numberOfLines = array.count*2;
    introduceLabel.textAlignment = NSTextAlignmentLeft;
    introduceLabel.font = [UIFont boldSystemFontOfSize:12.0];
    _introduceLabel = introduceLabel;
    
    return introduceLabel;
    
}

- (UIImageView *)headerImageView {
    if (_headerImageView) {
        return _headerImageView;
    }
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 150, kScreenWidth-40*2, 34)];
    headerImageView.image = [UIImage imageNamed:@"ic_wel_come"];
    _headerImageView = headerImageView;
    return _headerImageView;
    
}

@end
