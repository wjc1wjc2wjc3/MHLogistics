//
//  HZBItPopupView.m
//  HZBitApp
//
//  Created by Apple on 8/31/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "HZBitPopupView.h"
#import "HZBitPopupCellTableViewCell.h"


NSString *const strHZBitPopupCellTableViewCell = @"HZBitPopupCellTableViewCell";

@interface HZBitPopupView()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
    NSArray *_dataArray;
}
@end

@implementation HZBitPopupView {
 
}

- (instancetype)initHZBitPopupView:(NSArray *)dataArray
{
    if (self = [super init]) {
        
        [MMPopupWindow sharedWindow].touchWildToHide = YES;
        self.type = MMPopupTypeCustom;
        
        _dataArray = [NSMutableArray array];
        _dataArray = [dataArray mutableCopy];
        
        CGFloat tableViewHeight = 44 * _dataArray.count;
        CGFloat maxHeight = kScreenHeight - NAVIGATIONBAR_HEIGHT - 20 * 2;
        if (tableViewHeight > maxHeight) {
            tableViewHeight = maxHeight;
        }
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(tableViewHeight);
            make.width.mas_equalTo(kScreenWidth - 40);
        }];
        
        self.backgroundColor = [UIColor whiteColor];
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        _tableView = tableView;
        
        [tableView reloadData];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak __typeof__(self) weakSelf = self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.top.mas_equalTo(weakSelf.mas_top);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
    }];
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MHWeakSelf();
    [self hideWithBlock:^(MMPopupView *popUpView, BOOL bFinished) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(HZBitPopupViewItemSelected:index:)]) {
            [weakSelf.delegate HZBitPopupViewItemSelected:popUpView.tag index:indexPath.row];
        }
        
        if (weakSelf.block) {
            weakSelf.block(indexPath.row);
        }
    }];
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HZBitPopupCellTableViewCell *cell = (HZBitPopupCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:strHZBitPopupCellTableViewCell];
    if (!cell) {
        cell = [[HZBitPopupCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strHZBitPopupCellTableViewCell];
    }
    
    NSObject *indexObj = [_dataArray objectAtIndex:indexPath.row];
    if ([indexObj isKindOfClass:[NSString class]]) {
        [cell setPopTitle:(NSString *)indexObj];
    }


    return cell;
}

@end
