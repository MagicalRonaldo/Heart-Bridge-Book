//
//  APPManager.h
//  NoteBook
//
//  Created by xubing on 14-9-5.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPManager : NSObject

+ (BOOL)checkPhoneFunction;
+ (BOOL)isFirstLaunch;
+ (NSString *)getBundleVersion;

+ (BOOL)lowThanIOS7;
+ (BOOL)isiPhone4Display;
+ (CGFloat)getWindowHeight;
+ (CGFloat)getWindowWidth;

@end
