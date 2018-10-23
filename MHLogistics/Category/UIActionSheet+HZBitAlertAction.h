//
//  UIActionSheet+HZBitAlertAction.h
//  HZBitApp
//
//  Created by Apple on 9/5/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (HZBitAlertAction)<UIActionSheetDelegate>

- (void)showInView:(UIView *)view block:(void(^)(NSInteger idx,NSString* buttonTitle))block;

@end
