//
//  HBBaseViewController.h
//  NoteBook
//
//  Created by xubing on 14-9-18.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+HB.h"
#import "UILabel+HB.h"

#define STATUS_BAR_H 20
#define NAV_BAR_H 44
#define TAB_BAR_H 49 //系统部分Bar高度

#define FRAME_BETWEEN_NAV_TAB CGRectMake(0, 0, [self windowWidth], [self windowHeight]- STATUS_BAR_H - TAB_BAR_H - NAV_BAR_H)
#define FRAME_WITH_NAV CGRectMake(0, 0, [self windowWidth], [self windowHeight] - STATUS_BAR_H - NAV_BAR_H)
#define FRAME_WITH_TAB CGRectMake(0, 0, [self windowWidth], [self windowHeight] - 0 - TAB_BAR_H)
#define FRAME CGRectMake(0, 0, [self windowWidth], [self windowHeight])

#define ITEM_BTN_FRAME CGRectMake(0, 0, 55, 31)

typedef enum {
    SelectorBackTypePopBack = 0,
    SelectorBackTypeDismiss,
    SelectorBackTypePopToRoot,
    SelectorBackTypeNone
} SelectorBackType;

@interface HBBaseViewController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic, assign) SelectorBackType backType;
@property (nonatomic, assign) id delegateVC;
@property BOOL isHome;//判断是否是首页 是首页没有返回键

- (void)setTitleViewWithString:(NSString *)titleStr;

@end
