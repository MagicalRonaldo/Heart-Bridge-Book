//
//  AGImagePickerController+Helper.h
//  AGImagePickerController
//
//  Created by xubing on 14-1-13.
//  Copyright (c) 2014年 xubing. All rights reserved.
//
#import "AGImagePickerController.h"

@interface AGImagePickerController (Helper)

//  Configuring Rows
- (NSUInteger)defaultNumberOfItemsPerRow;
- (NSUInteger)numberOfItemsPerRow;

//  Configuring Selections
- (AGImagePickerControllerSelectionBehaviorType)selectionBehaviorInSingleSelectionMode;

- (BOOL)shouldDisplaySelectionInformation;
- (BOOL)shouldShowToolbarForManagingTheSelection;

//  Others
- (AGDeviceType)deviceType;
//  Drawing: Item
- (CGPoint)itemTopLeftPoint;
- (CGRect)itemRect;

//  Drawing: Checkmark
- (CGRect)checkmarkFrameUsingItemFrame:(CGRect)frame;

@end

@interface NSInvocation (Addon)

+ (id)invocationWithProtocol:(Protocol *)targetProtocol selector:(SEL)selector andRequiredFlag:(BOOL)isMethodRequired;

@end