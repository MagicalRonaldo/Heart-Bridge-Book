//
//  AGIPCGridCell.h
//  AGImagePickerController
//
//  Created by xubing on 14-1-13.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AGImagePickerController.h"

@interface AGIPCGridCell : UITableViewCell

@property (strong) NSArray *items;
@property (strong) AGImagePickerController *imagePickerController;

- (id)initWithImagePickerController:(AGImagePickerController *)imagePickerController items:(NSArray *)items andReuseIdentifier:(NSString *)identifier;

@end
