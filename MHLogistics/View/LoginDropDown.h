//
//  LoginDropDown.h
//  HZBitApp
//
//  Created by Apple on 8/31/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDropDownDelegate
- (void)clickRow:(NSString *)account;
- (void)deleteRow:(NSString *)account;
@end

@interface LoginDropDown : UIView<UITableViewDelegate , UITableViewDataSource>

@property UITableView *utv;//tableView

@property NSMutableArray *tableArray;//下拉列表数据

@property id<LoginDropDownDelegate> delegate;
@end
