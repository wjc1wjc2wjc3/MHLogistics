//
//  NSMutableArray+JC.m
//  HZBitSmartLock
//
//  Created by Apple on 2018/8/8.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "NSMutableArray+JC.h"

@implementation NSMutableArray (JC)

- (NSString *)json {
    NSError *error;
    NSData *listData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (!error) {
        NSString *recordListStr = [[NSString alloc] initWithData:listData encoding:NSUTF8StringEncoding];
        NSDictionary *javaJsonDict = @{@"data":recordListStr};
        
        NSError *javaError;
        NSData *javaJsonDictData = [NSJSONSerialization dataWithJSONObject:javaJsonDict options:NSJSONWritingPrettyPrinted error:&javaError];
        
        if (!javaError) {
            NSString *recordListStrJava = [[NSString alloc] initWithData:javaJsonDictData encoding:NSUTF8StringEncoding];
            
            return recordListStrJava;
        }
    }
    
    return @"";
    
}

@end
