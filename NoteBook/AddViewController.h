//
//  AddViewController.h
//  NoteBook
//
//  Created by xubing on 14-1-13.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "AGImagePickerController.h"
#import "Contact.h"

@interface AddViewController : UIViewController <UITextFieldDelegate, AVAudioRecorderDelegate, UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, AGImagePickerControllerDelegate> {
    AVAudioRecorder *recorder;
    NSTimer *timer;
    NSURL *urlPlay;
    NSURL *nameAudioUrl;
    NSURL *telephoneAudioUrl;
    NSURL *addressAudioUrl;
    NSMutableArray *selectedPhotos;
}

@property (nonatomic, strong) UIImageView *imageViewPhoto;
@property (nonatomic, strong) UIImageView *imageViewRecorder;
@property (nonatomic, strong) UIImageView *defaultImageShow;
@property (nonatomic, strong) UITextField *textFieldName;
@property (nonatomic, strong) UITextField *textFieldTelephone;
@property (nonatomic, strong) UITextField *textFieldAddress;
@property (nonatomic, strong) UIScrollView *scrollViewMain;
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) UIView *viewRecord;
@property (nonatomic, strong) UIView *defaultImageDisplay;
@property (nonatomic, strong) UILabel *recordNotes;
@property (nonatomic, strong) UIButton *doRecord;
@property (nonatomic, strong) UIButton *doTry;
@property (nonatomic, strong) UIButton *confirm;
@property (nonatomic, strong) AVAudioPlayer *avPlay;
@property (nonatomic, strong) AppDelegate *myDelegate;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) Contact *contact;
@property (nonatomic) BOOL editContact;
@property (nonatomic) BOOL edittedImage;
@property (nonatomic) BOOL edittedNameAudio;
@property (nonatomic) BOOL edittedTelephoneAudio;
@property (nonatomic) BOOL edittedAdressAudio;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void)nameBoFangBtnUpInside:(UIButton *)btn;
- (void)telephoneBoFangBtnUpInside:(UIButton *)btn;

@end
