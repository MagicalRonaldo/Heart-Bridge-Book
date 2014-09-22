//
//  BaseDeviceInfo.h
//  NoteBook
//
//  Created by xubing on 14-9-22.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <Foundation/Foundation.h>

//版本比较
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface BaseDeviceInfo : NSObject

+ (NSString *)deviceToken;
+ (NSString *)localIPAddress;
+ (NSString *)iosVersion;
+ (NSString *)appVersion;
+ (NSString *)appVersionNumber;
+ (NSString *)iosModel;
+ (UIDeviceBatteryState)batteryState;
+ (NSString *)totalDiskspace;
+ (NSString *)freeDiskspace;

@end
