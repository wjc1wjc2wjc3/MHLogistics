//
//  AvatarView.h
//  MHLogistics
//
//  Created by Apple on 2018/10/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AvatarDelegate <NSObject>

@optional
- (void)avatarSeleted:(NSUInteger)currentPage;

@end

@interface AvatarView : UIView

@property (nonatomic, weak) id<AvatarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame avatar:(NSArray *)avatarArr title:(NSArray *)titleArr;



@end

NS_ASSUME_NONNULL_END
