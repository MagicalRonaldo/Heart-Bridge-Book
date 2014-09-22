//
//  UIButton+HB.m
//  NoteBook
//
//  Created by xubing on 14-9-18.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "UIButton+HB.h"

@implementation UIButton (HB)

+ (UIButton *)buttonNomalColor:(UIColor *)nomalColor highLightColor:(UIColor *)hlColor coRadius:(CGFloat)radius
{
    UIButton *colorButton = [[UIButton alloc] init];
    [colorButton  setBackgroundImage:[UIImage createImageWithColor:nomalColor] forState:UIControlStateNormal];
    [colorButton setBackgroundImage:[UIImage createImageWithColor:hlColor] forState:UIControlStateHighlighted];
    colorButton.layer.cornerRadius  = radius;
    colorButton.layer.masksToBounds = YES;
    
    return colorButton;
}

+ (UIButton *)buttonTextColor:(UIColor *)TC cordius:(CGFloat)cor boderWidth:(CGFloat)width
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.tintColor = TC;
    button.backgroundColor = [UIColor clearColor];
    button.layer.cornerRadius  = cor;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [TC CGColor];
    button.layer.borderWidth = width;
    button.tintColor = [UIColor brownColor];
    
    return button;
}

- (void)setTitle:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)color
{
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = font;
    self.titleLabel.textColor = color;
}

@end
