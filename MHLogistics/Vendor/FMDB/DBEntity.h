//
//  DBEntity.h
//  HZBitApp
//
//  Created by Apple on 9/22/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBEntity : NSObject

@property (nonatomic, copy) NSString *User;
@property (nonatomic, copy) NSString *idx;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) NSString *issuance;
@property (nonatomic, copy) NSString *expiration;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *sid;

-(instancetype)initDictionary:(NSDictionary *)dict;

@end
