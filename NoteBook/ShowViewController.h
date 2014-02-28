//
//  ShowViewController.h
//  NoteBook
//
//  Created by xubing on 14-2-19.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "Contact.h"
#import "AppDelegate.h"

@interface ShowViewController : UIViewController<UINavigationControllerDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) Contact *contact;
@property (nonatomic, strong) AppDelegate *myDelegate;
@property (nonatomic, strong) UIScrollView *scrollViewMain;
@property (nonatomic, strong) AVAudioPlayer *avPlay;
@property (nonatomic, strong) UIImageView *image;

@end
