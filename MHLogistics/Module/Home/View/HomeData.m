//
//  HomeData.m
//  MHLogistics
//
//  Created by wjc on 10/27/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "HomeData.h"

@implementation HomeData

- (void)setTypeArray:(NSMutableArray *)typeArray {
    _typeArray = typeArray;
    _typeResArray = [NSMutableArray arrayWithCapacity:typeArray.count];
}

@end
