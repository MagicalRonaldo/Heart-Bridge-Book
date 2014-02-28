//
//  ALAsset+AGIPC.m
//  AGImagePickerController Demo
//
//  Created by xubing on 14-1-13.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "ALAsset+AGIPC.h"

@implementation ALAsset (AGIPC)

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    
    ALAsset *otherAsset = (ALAsset *)other;
    NSDictionary *selfUrls = [self valueForProperty:ALAssetPropertyURLs];
    NSDictionary *otherUrls = [otherAsset valueForProperty:ALAssetPropertyURLs];
    
    return [selfUrls isEqualToDictionary:otherUrls];
}

@end
