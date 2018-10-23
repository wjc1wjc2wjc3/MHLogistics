//
//  SearchView.h
//  HZBitSmartLock
//
//  Created by Apple on 2018/6/4.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, OperationPicType) {
    appAuthorize = 0,      //app授权
    identifyAuthorized,    //身份证授权
    aCardAuthorize,        //a卡授权
    wxAuthorized,          //微信授权
    
    noAnyAuthorized = -1   //没有任何授权,不显示操作说明
    
};

@protocol SearchViewDelegate <NSObject>

@optional
- (void) SearchResult:(NSString *)result;

@end

@interface SearchView : UIView


@property (nonatomic, assign) BOOL bShowSearch;
@property (nonatomic, weak) id<SearchViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame authType:(OperationPicType)type;
- (void)changeSearch;
@end
