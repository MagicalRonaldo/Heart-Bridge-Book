//
//  UIFont.m
//  NoteBook
//
//  Created by xubing on 14-9-4.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "UIFont+HB.h"

@implementation UIFont (HB)

+ (UIFont *)H1Font {
    return [UIFont systemFontOfSize:38/2];
}

+ (UIFont *)H2Font {
    return [UIFont systemFontOfSize:34/2];
}

+ (UIFont *)H3Font {
    return [UIFont systemFontOfSize:30/2];
}

+ (UIFont *)H4Font {
    return [UIFont systemFontOfSize:28/2];
}

+ (UIFont *)H5Font {
    return [UIFont systemFontOfSize:24/2];
}

+ (UIFont *)H1Font_B {
    return [UIFont boldSystemFontOfSize:38/2];
}

+ (UIFont *)H2Font_B {
    return [UIFont boldSystemFontOfSize:34/2];
}

+ (UIFont *)H3Font_B {
    return [UIFont boldSystemFontOfSize:30/2];
}

@end
