//
//  UploadDWCarAuthViewModel.m
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "UploadDWCarAuthViewModel.h"

@implementation UploadDWCarAuthViewModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    UploadDWCarAuthViewModel *viewModel = [UploadDWCarAuthViewModel mj_objectWithKeyValues:dictionary];
    return viewModel;
}

- (NSURLSessionDataTask *)startRequest:(NSDictionary *)param {
    
    return [APIManager SafePOST:[self formatUrl:kUploadDWCarAuth] parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
        
        UploadDWCarAuthViewModel *vm = [[UploadDWCarAuthViewModel alloc] initWithDictionary:responseObject];
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
