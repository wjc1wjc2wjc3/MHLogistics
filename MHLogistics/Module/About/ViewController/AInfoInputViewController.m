//
//  AInfoInputViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "AInfoInputViewController.h"
#import "AuthorizeLineView.h"

@interface AInfoInputViewController ()

@property (nonatomic, weak)AuthorizeLineView *alView;
@property (nonatomic, strong)NSArray *infoArray;
@end

@implementation AInfoInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.alView];
}

- (AuthorizeLineView *)alView {
    if (_alView) {
        return _alView;
    }
    
    CGRect rect = CGRectMake(0, 10, kScreenWidth, 30);
    _infoArray = @[LOCALIZEDSTRING(@"fillPersonalInfo"),LOCALIZEDSTRING(@"uploadPhoto"),LOCALIZEDSTRING(@"waitAuthorize")];
    AuthorizeLineView *alView = [[AuthorizeLineView alloc] initWithFrame:rect array:_infoArray];
    _alView = alView;
    return alView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:YES title:LOCALIZEDSTRING(@"authenticationInformationInput")];
}


@end
