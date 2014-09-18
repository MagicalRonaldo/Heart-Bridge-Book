//
//  UIButton+HB.h
//  NoteBook
//
//  Created by xubing on 14-9-18.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+HB.h"
#import "UIColor+HB.h"

@interface UIButton (HB)

+ (UIButton *)buttonNomalColor:(UIColor *)nomalColor highLightColor:(UIColor *)hlColor coRadius:(CGFloat)radius;

- (void)setTitle:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)color;

@end
