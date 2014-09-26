//
//  RecordAndPlayViewController.h
//  NoteBook
//
//  Created by xubing on 14-9-25.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

enum{
    ENC_AAC = 1,
    ENC_ALAC = 2,
    ENC_IMA4 = 3,
    ENC_ILBC = 4,
    ENC_ULAW = 5,
    ENC_PCM = 6,
} encodingTypes;

@interface RecordAndPlayViewController : UIViewController<AVAudioPlayerDelegate,AVAudioRecorderDelegate>

@property (nonatomic) NSInteger recordType;

@end
