//
//  AGIPCAssetsController.h
//  AGImagePickerController
//
//  Created by xubing on 14-1-13.
//  Copyright (c) 2014年 xubing. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>

#import "AGImagePickerController.h"
#import "AGIPCGridItem.h"

@interface AGIPCAssetsController : UITableViewController<UITableViewDataSource, UITableViewDelegate, AGIPCGridItemDelegate>

@property (strong) ALAssetsGroup *assetsGroup;
@property (ag_weak, readonly) NSArray *selectedAssets;
@property (strong) AGImagePickerController *imagePickerController;

- (id)initWithImagePickerController:(AGImagePickerController *)imagePickerController andAssetsGroup:(ALAssetsGroup *)assetsGroup;

@end
