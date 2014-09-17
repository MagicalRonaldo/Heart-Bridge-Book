//
//  UILabel+HB.h
//  NoteBook
//
//  Created by xubing on 14-9-17.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HB.h"
#import "UIFont+HB.h"

@interface UILabel (HB)

+ (UILabel *)labelFont:(UIFont *)font textColor:(UIColor *)color andText:(NSString *)text;
+ (UILabel *)labelFont:(UIFont *)font textColor:(UIColor *)TC;

@end
