//
//  RegisterViewModel.m
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "RegisterViewModel.h"

@implementation RegisterViewModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    RegisterViewModel *viewModel = [RegisterViewModel mj_objectWithKeyValues:dictionary];
    return viewModel;
}

- (NSURLSessionDataTask *)startRequest:(NSDictionary *)param {
    
    return [APIManager SafePOST:[self formatUrl:kRegister] parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
        
        RegisterViewModel *vm = [[RegisterViewModel alloc] initWithDictionary:responseObject];
        [MBManager showBriefAlert:vm.message];
        if (vm && [vm.status isEqualToString:@"1"]) {
            if (self.bitSuccessBlock) {
                self.bitSuccessBlock(vm);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        NSString *errorString = LOCALIZEDSTRING(@"networkException");
        [MBManager showBriefAlert:errorString];
        
        if (self.bitErrorCodeBlock) {
            self.bitErrorCodeBlock(errorString);
        }
    }];
    
}

@end
