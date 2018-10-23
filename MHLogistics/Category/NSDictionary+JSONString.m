//
//  NSDictionary+JSONString.m
//  HZBitApp
//
//  Created by Apple on 9/7/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "NSDictionary+JSONString.h"

@implementation NSDictionary (JSONString)

-(NSString *)JSONString{

    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
        DLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return jsonString;
}

@end
