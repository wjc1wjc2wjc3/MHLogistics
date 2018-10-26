//
//  AuthorizeLineView.h
//  MHLogistics
//
//  Created by Apple on 2018/10/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern CGFloat kPadding;


//授权线
@interface AuthorizeLineView : UIView

@property (nonatomic,assign) NSUInteger currentIdx;

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)bottomArray;

@end

NS_ASSUME_NONNULL_END
