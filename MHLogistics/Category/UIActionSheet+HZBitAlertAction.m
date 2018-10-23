//
//  UIActionSheet+HZBitAlertAction.m
//  HZBitApp
//
//  Created by Apple on 9/5/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "UIActionSheet+HZBitAlertAction.h"
#import <objc/runtime.h>

static char key;


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@implementation UIActionSheet (HZBitAlertAction)
#pragma clang diagnostic pop


- (void(^)(NSInteger idx,NSString* buttonTitle))block
{
    return objc_getAssociatedObject(self, &key);;
}
- (void)setBlock:(void(^)(NSInteger idx,NSString* buttonTitle))block
{
    if (block) {
        objc_setAssociatedObject(self, &key, block, OBJC_ASSOCIATION_COPY);
    }
}

- (void)showInView:(UIView *)view block:(void(^)(NSInteger idx,NSString* buttonTitle))block
{
    self.block = block;
    
    self.delegate = self;
    [self showInView:view];
}


#pragma mark
#pragma mark - UIActionSheetDelegate
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIAlertControllerStyle *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.block) {
        self.block(buttonIndex,[self buttonTitleAtIndex:buttonIndex]);
    }
    
    objc_removeAssociatedObjects(self);
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)actionSheetCancel:(UIAlertControllerStyle *)actionSheet
{
    objc_removeAssociatedObjects(self);
}


@end
