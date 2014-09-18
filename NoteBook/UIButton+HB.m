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

- (void)setTitle:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)color
{
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = font;
    self.titleLabel.textColor = color;
}

@end
