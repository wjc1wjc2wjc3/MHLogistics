//
//  DispatcherViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "DispatcherViewController.h"
#import "UIButton+Extension.h"

@interface DispatcherViewController ()

@property (nonatomic, weak) UILabel *headerLabel;
@property (nonatomic, weak) UILabel *introduceLabel;
@property (nonatomic, weak) UIButton *radioBtn;
@property (nonatomic, weak) NSMutableArray<UIImage *> *radioImageArr;

@property (nonatomic, weak) UILabel *agreeLabel;
@property (nonatomic, weak) UIButton *protocolBtn;
@property (nonatomic, weak) UIButton *nextBtn;

@end

@implementation DispatcherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.headerLabel];
    [self.view addSubview:self.introduceLabel];
    [self.view addSubview:self.radioBtn];
    [self.view addSubview:self.agreeLabel];
    [self.view addSubview:self.protocolBtn];
    [self.view addSubview:self.nextBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:NO title:LOCALIZEDSTRING(@"dispatcherCertification")];
}

- (UIButton *)radioBtn {
    UIButton *radioBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, self.introduceLabel.frame.origin.y + CGRectGetHeight(self.introduceLabel.frame), 40, 40)];
    [radioBtn addTarget:self action:@selector(radioAction:) forControlEvents:UIControlEventTouchUpInside];
    radioBtn.bSelected = NO;
    _radioBtn = radioBtn;
    return radioBtn;
}

- (void)radioAction:(UIButton *)button {
    DLog(@"showPwdAction");
    BOOL bSelected = button.bSelected;
    
}

- (UILabel *)introduceLabel {
    if (_introduceLabel) {
        return _introduceLabel;
    }
    
    UILabel *introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _headerLabel.frame.origin.y + CGRectGetHeight(_headerLabel.frame), kScreenWidth, 200)];
    introduceLabel.textColor = [UIColor blackColor];
    NSString *text = LOCALIZEDSTRING(@"authorizedInfo");
    NSArray *array = [text componentsSeparatedByString:@";"];
    NSMutableString *textM = [@"" mutableCopy];
    for (NSUInteger i = 0; i < array.count; i++) {
        [textM appendString:array[i]];
        if (i != array.count - 1) {
            [textM appendString:@"\n"];
        }
    }
    introduceLabel.text = text;
    introduceLabel.numberOfLines = array.count+1;
    introduceLabel.textAlignment = NSTextAlignmentCenter;
    introduceLabel.font = [UIFont boldSystemFontOfSize:17.0];
    _introduceLabel = introduceLabel;
    
    return introduceLabel;
    
}

- (UILabel *)headerLabel {
    if (_headerLabel) {
        return _headerLabel;
    }
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 100)];
    headerLabel.textColor = MainColor;
    headerLabel.text = @"WELCOME";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont boldSystemFontOfSize:30.0];
    _headerLabel = headerLabel;
    
    return headerLabel;
    
}

@end
