//
//  APPManager.m
//  NoteBook
//
//  Created by xubing on 14-9-5.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "APPManager.h"

@implementation APPManager

+ (BOOL)checkPhoneFunction
{
    UIDevice *device = [UIDevice currentDevice];
    if ([@"iPhone" isEqualToString:device.model])
        return YES;
    else
        return NO;
}

+ (NSString *)getBundleVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (BOOL)isFirstLaunch
{
    NSString *key = [NSString stringWithFormat:@"1stLaunch_%@", [self getBundleVersion]];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:key] isEqualToString:@"1"]) {
        return NO; //非首次登录
    }
    [self setLaunchingFlag]; //首次登录，展示引导页
    return YES;
}

+ (void)setLaunchingFlag
{ //将当前版本第一次开机falg固化
    NSString *key = [NSString stringWithFormat:@"1stLaunch_%@", [self getBundleVersion]];
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:key];
}

+ (NSString *)currentVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (BOOL)lowThanIOS7
{
    if ([[self currentVersion] floatValue] < 7) {
        return YES;
    }
    return NO;
}

+ (BOOL)isiPhone4Display
{ //是否是3.5寸屏幕
    if ([self getWindowHeight] <= 960/2) { //iPhone4\4s
        return YES;
    }
    
    return NO;
}

+ (CGFloat)getWindowHeight
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    return window.frame.size.height;
}

+ (CGFloat)getWindowWidth
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    return window.frame.size.width;
}

@end
