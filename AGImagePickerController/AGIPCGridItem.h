//
//  AGIPCGridItem.h
//  AGImagePickerController
//
//  Created by xubing on 14-1-13.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "AGImagePickerController.h"

@class AGIPCGridItem;

@protocol AGIPCGridItemDelegate <NSObject>

@optional
- (void)agGridItem:(AGIPCGridItem *)gridItem didChangeSelectionState:(NSNumber *)selected;
- (void)agGridItem:(AGIPCGridItem *)gridItem didChangeNumberOfSelections:(NSNumber *)numberOfSelections;
- (BOOL)agGridItemCanSelect:(AGIPCGridItem *)gridItem;

@end

@interface AGIPCGridItem : UIView

@property (assign) BOOL selected;
@property (strong) ALAsset *asset;

@property (nonatomic, ag_weak) id<AGIPCGridItemDelegate> delegate;

@property (strong) AGImagePickerController *imagePickerController;

- (id)initWithImagePickerController:(AGImagePickerController *)imagePickerController andAsset:(ALAsset *)asset;
- (id)initWithImagePickerController:(AGImagePickerController *)imagePickerController asset:(ALAsset *)asset andDelegate:(id<AGIPCGridItemDelegate>)delegate;

- (void)loadImageFromAsset;

- (void)tap;

+ (NSUInteger)numberOfSelections;

+ (void)resetNumberOfSelections;

@end
