//
//  UIImageView+HB.m
//  NoteBook
//
//  Created by xubing on 14-9-25.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "UIImageView+HB.h"

@implementation UIImageView (HB)

+ (UIImageView *)imageViewCordius:(CGFloat)cor
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.layer.cornerRadius = cor;
    imageView.layer.masksToBounds = YES;
    imageView.image = [UIImage imageNamed:@"08.png"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    return imageView;
}

@end
