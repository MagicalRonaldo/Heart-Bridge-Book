//
//  AGIPCAlbumsController.h
//  AGImagePickerController
//
//  Created by xubing on 14-1-13.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AGImagePickerController.h"

@interface AGIPCAlbumsController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong) AGImagePickerController *imagePickerController;

- (id)initWithImagePickerController:(AGImagePickerController *)imagePickerController;

@end
