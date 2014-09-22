//
//  BaseDeviceInfo.m
//  NoteBook
//
//  Created by xubing on 14-9-22.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "BaseDeviceInfo.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>

@implementation BaseDeviceInfo
+ (NSString *) hostname
{
    char baseHostName[256]; // Thanks, Gunnar Larisch
    int success = gethostname(baseHostName, 255);
    if (success != 0) return nil;
    baseHostName[255] = '\0';
    
#if TARGET_IPHONE_SIMULATOR
    return [NSString stringWithFormat:@"%s", baseHostName];
#else
    return [NSString stringWithFormat:@"%s.local", baseHostName];
#endif
}

+ (NSString *)localIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+ (NSString *)deviceToken
{
    return @"";
}

+ (NSString *)iosVersion {
    UIDevice *device = [UIDevice currentDevice];
    return [device systemVersion];
}

+ (NSString *)iosModel {
    UIDevice *device = [UIDevice currentDevice];
    return [device model];
}


+ (NSString *)appVersion {
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if (!appVersion || [appVersion length] == 0)
        appVersion = @"0.0";
    return appVersion;
}

+ (NSString *)appVersionNumber
{
    NSString *appV = [BaseDeviceInfo appVersion];
    char c;
    for (int i = 0; i < [appV length]; ++ i) {
        c = [appV characterAtIndex:i];
        if (c >= '0' && c <= '9') {
            appV = [appV substringFromIndex:i];
            break;
        }
    }
    
    for (int i = (int)[appV length] - 1; i >= 0; -- i) {
        c = [appV characterAtIndex:i];
        if (c >= '0' && c <= '9') {
            appV = [appV substringToIndex:i+1];
            break;
        }
    }
    
    return appV;
}

+ (NSString *)freeDiskspace {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    } else {
        
    }
    
    return [NSString stringWithFormat:@"%llu", ((totalFreeSpace/1024ll)/1024ll)];
}

+ (NSString *)totalDiskspace {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    }
    
    return [NSString stringWithFormat:@"%llu", ((totalSpace/1024ll)/1024ll)];
}

+ (UIDeviceBatteryState)batteryState {
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    
    return [[UIDevice currentDevice] batteryState];
}


@end
