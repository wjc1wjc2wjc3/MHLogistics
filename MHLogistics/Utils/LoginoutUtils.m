//
//  LoginoutUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 18/01/2018.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "LoginoutUtils.h"
#import "LoginInfoUtils.h"
#import "AccountUtils.h"
#import "ViewControllerUtils.h"
#import "LoginViewModel.h"
#import "LoginViewController.h"

@implementation LoginoutUtils

+ (void)loginOut:(NSString *)payloadMsg {
    NSString *account = [AccountUtils getAccount];
    UIViewController *vc = [ViewControllerUtils currentViewController];
    if ([LoginInfoUtils getLoginState:account] != online || [vc isKindOfClass:[LoginViewController class]]) {
        return;
    }
    
    NSString *title = [payloadMsg stringByReplacingOccurrencesOfString:@"null" withString:@""];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:LOCALIZEDSTRING(@"cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSString *loginAccount = [AccountUtils getAccount];
        if (loginAccount) {
            [LoginInfoUtils saveLoginState:offline loginName:loginAccount];
        }
        [ViewControllerUtils showLoginViewController];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:LOCALIZEDSTRING(@"relogin") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *account = [AccountUtils getAccount];
        if (account) {
            if (account) {
                [LoginInfoUtils saveLoginState:offline loginName:account];
            }
            [ViewControllerUtils showLoginViewController];
            
//            NSString *pwd = [AccountUtils getAccountPWD];
//            if (!pwd || [@"" isEqualToString:pwd]) {
//
//            }
//            else
//            {
//                [LoginViewModel startLogin:account pwd:pwd];
//            }
        }
        
    }]];
    
    [vc presentViewController:alertVC animated:YES completion:nil];
}

@end
