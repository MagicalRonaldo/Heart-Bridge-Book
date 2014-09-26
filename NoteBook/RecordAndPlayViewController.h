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

@protocol RecordFinishRelegate <NSObject>

- (void)doFinishRecordWithUrl:(NSURL *)url tag:(NSInteger) i;

@end

@interface RecordAndPlayViewController : UIViewController<AVAudioPlayerDelegate,AVAudioRecorderDelegate>

@property (nonatomic) NSInteger recordType;
@property (nonatomic, strong) id<RecordFinishRelegate> recordDelegate;

@end
