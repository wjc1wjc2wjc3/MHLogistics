//
//  UIAlertView+HZBitAlertAction.m
//  HZBitApp
//
//  Created by Apple on 9/5/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "UIAlertView+HZBitAlertAction.h"
#import <objc/runtime.h>

static char key;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@implementation UIAlertView (HZBitAlertAction)
#pragma clang diagnostic pop

- (void(^)(NSInteger buttonIndex))block
{
    return objc_getAssociatedObject(self, &key);;
}
- (void)setBlock:(void(^)(NSInteger buttonIndex))block
{
    if (block) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, &key, block, OBJC_ASSOCIATION_COPY);
    }
}


- (void)showWithBlock:(void(^)(NSInteger buttonIndex))block
{
    self.block = block;
    self.delegate = self;
    
    [self show];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
#pragma clang diagnostic pop
{
    if (self.block)
    {
        self.block(buttonIndex);
    }
    
    objc_removeAssociatedObjects(self);
}



@end
