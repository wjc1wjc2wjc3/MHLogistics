//
//  AboutViewController.m
//  MHLogistics
//
//  Created by Apple on 2018/10/23.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "AboutViewController.h"
#import "DispatcherViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNaviBar:NO title:LOCALIZEDSTRING(@"me")];
    
    [self showAuthor];
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
    [self.navigationController pushViewController:vc animated:YES];
}

@end
