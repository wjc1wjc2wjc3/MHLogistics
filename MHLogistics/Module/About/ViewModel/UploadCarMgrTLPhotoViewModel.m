//
//  UploadCarMgrTLPhotoViewModel.m
//  MHLogistics
//
//  Created by Apple on 2018/10/30.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "UploadCarMgrTLPhotoViewModel.h"

@implementation UploadCarMgrTLPhotoViewModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    UploadCarMgrTLPhotoViewModel *viewModel = [UploadCarMgrTLPhotoViewModel mj_objectWithKeyValues:dictionary];
    return viewModel;
}

- (NSURLSessionDataTask *)startRequest:(NSDictionary *)param {
    
    return [APIManager SafePOST:[self formatUrl:kUploadCarMgrTLPhoto] parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
        
        UploadCarMgrTLPhotoViewModel *vm = [[UploadCarMgrTLPhotoViewModel alloc] initWithDictionary:responseObject];
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
