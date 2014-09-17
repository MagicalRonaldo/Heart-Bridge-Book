//
//  UILabel+HB.m
//  NoteBook
//
//  Created by xubing on 14-9-17.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "UILabel+HB.h"


@implementation UILabel (HB)

+ (UILabel *)labelFont:(UIFont *)font textColor:(UIColor *)color andText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = color;
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

+ (UILabel *)labelFont:(UIFont *)font textColor:(UIColor *)TC
{
    UILabel *lab = [[UILabel alloc] init];
    lab.font = font;
    lab.textColor = TC;
    lab.backgroundColor = [UIColor clearColor];
    return lab;
}

@end
