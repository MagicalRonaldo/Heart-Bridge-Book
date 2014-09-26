//
//  HandleContactViewController.h
//  NoteBook
//
//  Created by xubing on 14-9-18.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBBaseViewController.h"
#import "AGImagePickerController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface HandleContactViewController : HBBaseViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIActionSheetDelegate,UIImagePickerControllerDelegate, AGImagePickerControllerDelegate, AVAudioPlayerDelegate>

@end
