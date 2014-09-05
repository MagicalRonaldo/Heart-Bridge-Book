//
//  UIColor+HB.h
//  NoteBook
//
//  Created by xubing on 14-9-4.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HB)

+ (UIColor *)colorWithHex:(uint) hex alpha:(CGFloat)alpha;

//标题大字，正文内容 38,38,38
+ (UIColor *)BlackColor;

//小标题，附属说明文字 85,85,85
+ (UIColor *)DarkGrayColor;

//小标题，附属说明文字 150,150,150
+ (UIColor *)MiddleGrayColor;

//输入框内的提示文字 204,204,206
+ (UIColor *)LightGrayColor;

//255,255,255
+ (UIColor *)WhiteColor;

//按钮文字，链接文字 100,169,0
+ (UIColor *)GreenColor;

//房价，套数 229,75,0
+ (UIColor *)OrangeColor;

//各页面背景 244,244,244
+ (UIColor *)BackgroundPageColor;

//部分栏的背景色 248,248,249
+ (UIColor *)BackgroundBarColor;

//内容区的背景色 255,255,255
+ (UIColor *)BackgroundContentColor;

//页面和列表的分割线 204,204,204
+ (UIColor *)LineColor;

//选中背景色 234,234,234
+ (UIColor *)BgSelectColor;

//深绿 35,140,0
+ (UIColor *)DarkGreenColor;

//文字按钮色 60,60,61
+ (UIColor *)BtnText;

//蓝色 55,90,162
+ (UIColor *)BlueColor;

//导航栏背景色 244,244,244
+ (UIColor *)BgNavigationColor;

//导航栏标题色 102,102,102
+ (UIColor *)BgTitleColor;

//导航栏动作色 38,38,38
+ (UIColor *)BgActionColor;

//标签栏背景色 246,246,246
+ (UIColor *)BgTabColor;

+ (UIColor *)BgTagColor;

+ (UIColor *)GrayLine1Color;

+ (UIColor *)GrayLine2Color;

+ (UIColor *)BorderColor;

+ (UIColor *)FilterSelectedColor;

+ (UIColor *)FilterCellSeparatorLineColor;

+ (UIColor *)colorWithHexString: (NSString *)stringToConvert;

@end
