//
//  HZBitActivityIndicatorView.h
//  HZBitApp
//
//  Created by Apple on 9/21/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZBitActivityIndicatorView : UIView

+(_Nonnull instancetype)defaultIndicator;

@property(nonatomic) BOOL hidesWhenStopped;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;



@end
