//
//  UIImage+HB.h
//  NoteBook
//
//  Created by xubing on 14-9-5.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HB)

- (UIImage *)autoResizableWidthImage;
- (UIImage *)autoResizableHeightImage;
- (UIImage *)autoResizableImage;

+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)resizeImage:(UIImage *)image size:(CGSize)size;
+ (UIImage *)createMaskWithImage:(UIImage *)image outColor:(UIColor *)outColor innerColor:(UIColor *)innerColor;
+ (UIImage *)autoGetImage:(NSString *)fileName;

+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;

@end
