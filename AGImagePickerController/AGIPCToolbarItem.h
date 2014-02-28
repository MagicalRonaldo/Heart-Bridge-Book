//
//  AGIPCToolbarItem.h
//  AGImagePickerController
//
//  Created by xubing on 14-1-13.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef BOOL (^AGIPCAssetIsSelectedBlock)(NSUInteger index, ALAsset *asset);

@interface AGIPCToolbarItem : NSObject {
    AGIPCAssetIsSelectedBlock assetIsSelectedBlock;
    UIBarButtonItem *barButtonItem;
}

@property (strong) UIBarButtonItem *barButtonItem;
@property (copy) AGIPCAssetIsSelectedBlock assetIsSelectedBlock;

- (id)initWithBarButtonItem:(UIBarButtonItem *)theBarButtonItem;
- (id)initWithBarButtonItem:(UIBarButtonItem *)theBarButtonItem andSelectionBlock:(AGIPCAssetIsSelectedBlock)theSelectionBlock;

@end
