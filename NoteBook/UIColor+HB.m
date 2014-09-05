//
//  UIColor+HB.m
//  NoteBook
//
//  Created by xubing on 14-9-4.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "UIColor+HB.h"

@implementation UIColor (HB)

+ (UIColor *) colorWithHex:(uint) hex alpha:(CGFloat)alpha
{
	int red, green, blue;
	
	blue = hex & 0x0000FF;
	green = ((hex & 0x00FF00) >> 8);
	red = ((hex & 0xFF0000) >> 16);
	
	return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

+ (UIColor *)BlackColor {
    return [UIColor colorWithHex:0x262626 alpha:1];
}

+ (UIColor *)DarkGrayColor {
    return [UIColor colorWithHex:0x555555 alpha:1];
}

+ (UIColor *)MiddleGrayColor {
    return [UIColor colorWithHex:0x969696 alpha:1];
}

+ (UIColor *)LightGrayColor {
    return [UIColor colorWithHex:0xccccce alpha:1];
}

+ (UIColor *)WhiteColor {
    return [UIColor colorWithHex:0xffffff alpha:1];
}

+ (UIColor *)OrangeColor {
    return [UIColor colorWithHex:0xe54b00 alpha:1];
}

+ (UIColor *)BackgroundPageColor {
    return [UIColor colorWithHex:0xf4f4f4 alpha:1];
}

+ (UIColor *)BackgroundBarColor {
    return [UIColor colorWithHex:0xf8f8f9 alpha:1];
}

+ (UIColor *)BackgroundContentColor {
    return [UIColor colorWithHex:0xffffff alpha:1];
}

+ (UIColor *)LineColor {
    return [UIColor colorWithHex:0xcccccc alpha:1];
}

+ (UIColor *)BgSelectColor {
    return [UIColor colorWithHex:0xEAEAEA alpha:1];
}

+ (UIColor *)GreenColor {
    return [UIColor colorWithHex:0x69Af00 alpha:1];
}

+ (UIColor *)DarkGreenColor {
    return [UIColor colorWithHex:0x238C00 alpha:1];
}

+ (UIColor *)BtnText {
    return [UIColor colorWithHex:0x3c3c3d alpha:1];
}

+ (UIColor *)BlueColor {
    return [UIColor colorWithHex:0x375aa2 alpha:1];
}

+ (UIColor *)BgNavigationColor {
    return [UIColor colorWithHex:0xf4f4f4 alpha:1];
}

+ (UIColor *)BgTitleColor {
    return [UIColor colorWithHex:0x555555 alpha:1];
}

+ (UIColor *)BgActionColor {
    return [UIColor colorWithHex:0x262626 alpha:1];
}

+ (UIColor *)BgTabColor {
    return [UIColor colorWithHex:0xf6f6f6 alpha:1];
}

+ (UIColor *)BgTagColor {
    return [UIColor colorWithHex:0xE7F1DB alpha:1];
}

+ (UIColor *)GrayLine1Color{
    return [self colorWithHex:0xc6c6c6 alpha:1];
}

+ (UIColor *)GrayLine2Color
{
    return [self colorWithHex:0xCFCFCF alpha:1];
}

+ (UIColor *)BorderColor
{
    return [UIColor colorWithHex:0xeeeeee alpha:1];
}

+ (UIColor *)FilterSelectedColor
{
    return [UIColor colorWithHex:0x5da500 alpha:1];
}

+ (UIColor *)FilterCellSeparatorLineColor
{
    return [UIColor colorWithRed:.783922 green:.780392 blue:.8 alpha:1];
}

+ (UIColor *)colorWithHexString: (NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor BlackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor BlackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
