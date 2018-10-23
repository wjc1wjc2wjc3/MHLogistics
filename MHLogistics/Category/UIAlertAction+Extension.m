//
//  UIAlertAction+Extension.m
//  HZBitSmartLock
//
//  Created by Apple on 2018/6/4.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "UIAlertAction+Extension.h"

static const char *kKey = "AlertActionTag";

@implementation UIAlertAction (Extension)

- (void)setKey:(NSString *)key {
    objc_setAssociatedObject(self, kKey, key, OBJC_ASSOCIATION_COPY);
}

- (NSString *)key {
    return objc_getAssociatedObject(self, kKey);
}

@end
