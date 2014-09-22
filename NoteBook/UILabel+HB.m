//
//  UILabel+HB.m
//  NoteBook
//
//  Created by xubing on 14-9-17.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "UILabel+HB.h"


@implementation UILabel (HB)

+ (UILabel *)labelFont:(UIFont *)font textColor:(UIColor *)color Text:(NSString *)text
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

+ (UILabel *)getTitleView:(NSString *)titleStr
{
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    lb.backgroundColor = [UIColor clearColor];
    lb.font = [UIFont systemFontOfSize:20];
    lb.text = titleStr;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor WhiteColor];
    
    return lb;
}

@end
