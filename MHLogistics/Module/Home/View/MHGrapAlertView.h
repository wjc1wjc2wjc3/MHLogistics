//
//  MHGrapAlertView.h
//  MHLogistics
//
//  Created by wjc on 10/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeData.h"

typedef void(^MHGrapBlock)(void);

@interface MHGrapAlertView : UIViewController

+ (instancetype)showGrapWithData:(HomeData *)data grapBlock:(MHGrapBlock)grapBlock;

@end
