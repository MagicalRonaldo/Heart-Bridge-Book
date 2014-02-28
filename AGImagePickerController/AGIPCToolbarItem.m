//
//  AGIPCToolbarItem.m
//  AGImagePickerController
//
//  Created by xubing on 14-1-13.
//  Copyright (c) 2014年 xubing. All rights reserved.
//
#import "AGIPCToolbarItem.h"

@implementation AGIPCToolbarItem

#pragma mark - Properties

@synthesize assetIsSelectedBlock, barButtonItem;

#pragma mark - Object Lifecycle


#pragma mark - Designated Initializer

- (id)initWithBarButtonItem:(UIBarButtonItem *)theBarButtonItem andSelectionBlock:(AGIPCAssetIsSelectedBlock)theSelectionBlock {
    self = [super init];
    if (self)
    {
        self.barButtonItem = theBarButtonItem;
        self.assetIsSelectedBlock = theSelectionBlock;
    }
    
    return self;
}

#pragma mark - Initializers

- (id)initWithBarButtonItem:(UIBarButtonItem *)theBarButtonItem {
    return [self initWithBarButtonItem:theBarButtonItem andSelectionBlock:nil];
}

@end
