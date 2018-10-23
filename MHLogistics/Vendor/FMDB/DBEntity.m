//
//  DBEntity.m
//  HZBitApp
//
//  Created by Apple on 9/22/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "DBEntity.h"

@implementation DBEntity

-(instancetype)initDictionary:(NSDictionary *)dict {
    DBEntity *entity = [DBEntity mj_objectWithKeyValues:dict];
    return entity;
}

@end
