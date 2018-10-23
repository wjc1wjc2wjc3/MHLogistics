//
//  Macro.h
//  HZBitApp
//
//  Created by Apple on 8/30/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//获取本地语言
#define LOCALIZEDSTRING(str) NSLocalizedString(str, "")

//主页蓝
#define MainColor RGB(0xF7, 0xB8, 0x49)
#define GrayColor RGB(220, 220, 220)

#define BlueColor RGB(0x00, 0xAE, 0xFF)
//电话号码长度
#define PHONE_NUMBER_LENGTH 11

#define QR_DECRIPTION_COLOR RGB(150, 150, 150)

#define VC_COLOR_BG RGB(220, 220, 220)

#define NAVIBAR_BLUE RGB(0x28, 0x92, 0xE3)

#define NAVIGATIONBAR_HEIGHT 50

#define HZ_BIT_BLUE RGB(40, 146, 227)

#define HZ_BIT_ICON_SIZE CGSizeMake(120, 60)

#define SPLIT_LINE_COLOR RGB(200, 200, 200)

#define SPLIT_LINE_HEIGHT 1.0
#define SPLIT_LINE_PADDING 15.0

#define LOGIN_HEIGHT 55.0

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScale [[UIScreen mainScreen] scale]
#define ABOUT_HEAEDER_HEIGHT 200
#define ABOUT_ITEM_HEIGHT 180

#define MAINPAGE_HEADER_HEIGHT 200
#define MAINPAGE_HEADER_SPLIT_HEIGHT 2
#define MAINPAGE_MIDDLE_HEIGHT 110
#define MAINPAGE_MIDDLE_BUTTON_HEIGHT 100

#define CELL_ITEM_HEIGHT 60.0

#define CORNER_RADIUS 5.0

#define kSearchHeight 50  //搜索栏高度
#define kSearchPadding 25  //搜索栏水平间距
#define kManagerHeaderHeight 25  //搜索栏头部高度
#endif /* Macro_h */
