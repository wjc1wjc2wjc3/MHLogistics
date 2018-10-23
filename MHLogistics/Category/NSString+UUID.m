//
//  NSString+UUID.m
//  HZBitSmartLock
//
//  Created by Apple on 10/11/2017.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "NSString+UUID.h"

@implementation NSString (UUID)

+ (NSString *)createUUID:(NSString *)name {
    
    if (!name || name.length == 0) {
        return name;
    }
    
    NSInteger length = name.length;
    if (length < 32) {
        NSInteger patchesLength = 32 - length;
        for (NSInteger i = 0; i < patchesLength; i++) {
            name = [name stringByAppendingString:@"0"];
        }
    }
    
    length = name.length;
    NSMutableString *uuidName = [[NSMutableString alloc] initWithString:name];
    if(length > 24) {
        
        [uuidName insertString:@"-" atIndex:8];
        [uuidName insertString:@"-" atIndex:13];
        [uuidName insertString:@"-" atIndex:18];
        [uuidName insertString:@"-" atIndex:23];
    }
    else
        if(length > 20) {
        
        [uuidName insertString:@"-" atIndex:8];
        [uuidName insertString:@"-" atIndex:13];
        [uuidName insertString:@"-" atIndex:18];
        [uuidName insertString:@"-" atIndex:23];
    }
    else if(length > 16)
    {
        [uuidName insertString:@"-" atIndex:8];
        [uuidName insertString:@"-" atIndex:13];
        [uuidName insertString:@"-" atIndex:18];
    }
    else if(length > 12)
    {
        [uuidName insertString:@"-" atIndex:8];
        [uuidName insertString:@"-" atIndex:13];
    }
    else if(length > 8)
    {
        [uuidName insertString:@"-" atIndex:8];
    }
    
    return uuidName;
}

@end
