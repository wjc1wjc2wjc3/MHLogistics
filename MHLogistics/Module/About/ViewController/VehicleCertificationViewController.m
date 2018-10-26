//
//  VehicleCertificationViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VehicleCertificationViewController.h"
#import "UIImage+Color.h"
#import "UIButton+Extension.h"

@interface VehicleCertificationViewController ()

@property (nonatomic, weak) UIImageView *cardImageView;
@property (nonatomic, weak) UILabel *ruleLabel;
@property (nonatomic, weak) UILabel *selectedLabel;
@property (nonatomic, strong) NSArray *selectedTitleArray;
@property (nonatomic, strong) NSMutableArray *radioBtnArray;
@property (nonatomic, assign) NSUInteger selectedType;
@property (nonatomic, weak) UIView *selectedViewT;
@property (nonatomic, weak) UIView *selectedViewS;
@property (nonatomic, weak) UIButton *startBtn;

@end

@implementation VehicleCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.cardImageView];
    [self.view addSubview:self.ruleLabel];
    [self.view addSubview:self.selectedLabel];
    
    _selectedTitleArray = @[LOCALIZEDSTRING(@"tonnageVehicle"), LOCALIZEDSTRING(@"selfContainedCabinet")];
    _radioBtnArray = [NSMutableArray arrayWithCapacity:_selectedTitleArray.count];
    CGFloat x = _selectedLabel.frame.origin.x;
    for (NSUInteger i = 0; i < _selectedTitleArray.count; i++) {
        UIButton *btn = [self createSelected:CGRectMake(x, _selectedLabel.frame.origin.y + _selectedLabel.frame.size.height + 40*i, kScreenWidth - x*2, 40) title:_selectedTitleArray[i]];
        [btn setTag:i];
    }
    [self setSelected:0];
    [self.view addSubview:self.startBtn];
}

- (UIButton *)createSelected:(CGRect)rect title:(NSString *)title {
    
    UIView *baseView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:baseView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:13.0];
    [baseView addSubview:titleLabel];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(rect.size.width - 40, 0, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:btn];
    [_radioBtnArray addObject:btn];
    return btn;
}

- (void)setSelected:(NSUInteger)idx {
    for (NSUInteger i = 0; i < _radioBtnArray.count; i++) {
        UIButton *btn = _radioBtnArray[i];
        BOOL bSelected = idx == i ? YES : NO;
        [btn setSelected:bSelected];
        NSString *selectedRes = bSelected ? @"radio_on" : @"radio_off";
        [btn setImage:[UIImage imageNamed:selectedRes] forState:UIControlStateNormal];
    }
}

- (void)selectAction:(UIButton *)button {
    BOOL bSelected = button.bSelected;
    if (!bSelected) {
        [self setSelected:button.tag];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:YES title:LOCALIZEDSTRING(@"dopCarVCAuthorized")];
}

- (UIImageView *)cardImageView {
    if (_cardImageView) {
        return _cardImageView;
    }
    
    UIImageView *cardImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vehicle_auth"]];
    cardImageView.frame = CGRectMake((kScreenWidth -214)*0.5, 100, 214, 120);
    _cardImageView = cardImageView;
    return cardImageView;
}

- (UILabel *)ruleLabel {
    if (_ruleLabel) {
        return _ruleLabel;
    }
    NSString *info = LOCALIZEDSTRING(@"vehicleAuthorizedRule");
    NSArray *infoArray = [info componentsSeparatedByString:@";"];
    NSMutableString *infoM = [@"" mutableCopy];
    [infoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [infoM appendString:obj];
        if (idx != infoArray.count - 1) {
            [infoM appendString:@"\n\n"];
        }
    }];
    UILabel *ruleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _cardImageView.frame.origin.y + CGRectGetHeight(_cardImageView.frame) + 10, kScreenWidth - 20*2, 120)];
    ruleLabel.font = [UIFont systemFontOfSize:13.0];
    ruleLabel.numberOfLines = (infoArray.count-1)*3 + 1;
    ruleLabel.text = infoM;
    _ruleLabel = ruleLabel;
    return ruleLabel;
}

- (UILabel *)selectedLabel {
    if (_selectedLabel) {
        return _selectedLabel;
    }
    CGFloat x = 50;
    UILabel *selectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, _ruleLabel.frame.origin.y + CGRectGetHeight(_ruleLabel.frame) + 10, kScreenWidth - x*2, 50)];
    selectedLabel.text = LOCALIZEDSTRING(@"pleaseSelectedAuthorized");
    _selectedLabel = selectedLabel;
    return selectedLabel;
}

- (UIButton *)startBtn {
    if (_startBtn) {
        return _startBtn;
    }
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, kScreenHeight - 100, kScreenWidth - 40*2, 40)];
    [startBtn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setBackgroundImage:[UIImage createImageWithColor:MainColor] forState:UIControlStateNormal];
    [startBtn setTitle:LOCALIZEDSTRING(@"startAuthorized") forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startBtn.layer.cornerRadius = 20;
    startBtn.layer.masksToBounds = YES;
    startBtn.enabled = NO;
    _startBtn = startBtn;
    return startBtn;
}

- (void)start:(UIButton *)button {
    DLog(@"start");
}

@end
