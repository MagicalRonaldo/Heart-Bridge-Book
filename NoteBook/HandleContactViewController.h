//
//  HandleContactViewController.h
//  NoteBook
//
//  Created by xubing on 14-9-18.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBBaseViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "AGImagePickerController.h"
#import "Contact.h"

@interface HandleContactViewController : HBBaseViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) Contact *contact;

@end
