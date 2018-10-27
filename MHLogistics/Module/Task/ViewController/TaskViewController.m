//
//  TaskViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/23.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "TaskViewController.h"
#import "SliderHeaderView.h"

@interface TaskViewController ()

@property (nonatomic, weak) SliderHeaderView *shView;
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.shView];
}

- (SliderHeaderView *)shView {
    if (_shView) {
        return _shView;
    }
    
    NSArray *array = @[LOCALIZEDSTRING(@"excuting"), LOCALIZEDSTRING(@"excuted")];
    SliderHeaderView *shView = [[SliderHeaderView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, 40) array:array];
    shView.block = ^(NSUInteger tag) {
        
    };
    _shView = shView;
    
    return _shView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:NO title:LOCALIZEDSTRING(@"zgCardTitle")];
    
}

@end
