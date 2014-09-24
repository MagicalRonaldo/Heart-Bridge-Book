//
//  HandleContactViewController.h
//  NoteBook
//
//  Created by xubing on 14-9-18.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "HBBaseViewController.h"
#import "AGImagePickerController.h"

@interface HandleContactViewController : HBBaseViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIActionSheetDelegate,UIImagePickerControllerDelegate, AGImagePickerControllerDelegate>

@property (nonatomic, strong) Contact *contact;

@end
