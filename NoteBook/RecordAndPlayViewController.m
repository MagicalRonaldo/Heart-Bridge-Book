//
//  RecordAndPlayViewController.m
//  NoteBook
//
//  Created by xubing on 14-9-25.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "RecordAndPlayViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@interface RecordAndPlayViewController ()

@property (nonatomic, strong) UIView *viewRecord;
@property (nonatomic, strong) UIImageView *imageViewRecorder;
@property (nonatomic, strong) UILabel *recordNotes;
@property (nonatomic, strong) UIButton *doRecord;
@property (nonatomic, strong) UIButton *doTry;
@property (nonatomic, strong) UIButton *confirm;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;

@property (nonatomic, strong) NSTimer *timerForPitch;
@property (nonatomic, strong) NSMutableDictionary *recordSettings;
@property (nonatomic, strong) NSURL *url;

@property (nonatomic) int recordEncoding;

@end

@implementation RecordAndPlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self audioPathSetting];
    
    self.viewRecord = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.viewRecord.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
    [self.view addSubview:self.viewRecord];
    
    self.recordNotes = [[UILabel alloc] initWithFrame:(CGRectMake(20, 60, 280, 20))];
    self.recordNotes.text = @"请注意：您按住按钮进行录音，可以按住不动向上拖拽即放弃本次录音；请语调缓慢以确保录音清晰";
    self.recordNotes.backgroundColor = [UIColor clearColor];
    self.recordNotes.textColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.8 alpha:1];
    self.recordNotes.lineBreakMode = NSLineBreakByWordWrapping;
    self.recordNotes.numberOfLines = 2;
    [self.recordNotes sizeToFit];
    [self.viewRecord addSubview:self.recordNotes];
    
    self.imageViewRecorder = [[UIImageView alloc] initWithFrame:(CGRectMake(60, 140, 200, 200))];
    self.imageViewRecorder.image = [UIImage imageNamed:@"record_animate_01.png"];
    [self.viewRecord addSubview:self.imageViewRecorder];
    
    self.doRecord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.doRecord.frame = CGRectMake(60, 380, 200, 50);
    [self.doRecord setTitle:@"开      始      录      音" forState:UIControlStateNormal];
    [self.doRecord addTarget:self action:@selector(recordBtnDown:) forControlEvents:UIControlEventTouchDown];
    [self.doRecord addTarget:self action:@selector(recordBtnDragUp:) forControlEvents:UIControlEventTouchDragOutside];
    [self.doRecord addTarget:self action:@selector(recordBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewRecord addSubview:self.doRecord];
    
    self.doTry = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.doTry.frame = CGRectMake(60, 445, 200, 50);
    [self.doTry setTitle:@"试      听      录      音" forState:UIControlStateNormal];
    [self.doTry addTarget:self action:@selector(playBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewRecord addSubview:self.doTry];
    
    self.confirm = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.confirm.frame = CGRectMake(60, 510, 200, 50);
    [self.confirm setTitle:@"确      认      保      存" forState:UIControlStateNormal];
    [self.confirm addTarget:self action:@selector(btnSaveUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewRecord addSubview:self.confirm];
}

- (void)recordBtnDown:(UIButton *)recordBtn
{
    [self.doRecord setTitle:@"正      在      录      音" forState:UIControlStateNormal];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    self.audioRecorder = nil;
    
    [self audioRecordSetting];
    
    NSError *error = nil;
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:self.url settings:self.recordSettings error:&error];
    self.audioRecorder.meteringEnabled = YES;
    if ([self.audioRecorder prepareToRecord] == YES) {
        self.audioRecorder.meteringEnabled = YES;
        [self.audioRecorder record];
        self.timerForPitch =[NSTimer scheduledTimerWithTimeInterval: 0.01 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    } else {
    }
}

-(void)recordBtnDragUp:(UIButton *)recordBtn
{
    //删除录制文件
    [self.audioRecorder stop];
    [self.audioRecorder deleteRecording];
    [self.timerForPitch invalidate];
    self.timerForPitch = nil;
    NSLog(@"取消发送");
}

-(void)recordBtnUpInside:(UIButton *)recordBtn
{
    [self.doRecord setTitle:@"开      始      录      音" forState:UIControlStateNormal];
    double cTime = self.audioRecorder.currentTime;
    if (1 < cTime < 180 ) {
        //如果录制时间在1s到120s之间，则保存录音数据
        [self.audioRecorder stop];
        NSLog(@"已保存");
    } else {
        //删除记录的文件
        [self.audioRecorder stop];
        [self.audioRecorder deleteRecording];
        NSLog(@"因录制的音频不符合条件，已删除");
    }
    [self.timerForPitch invalidate];
    self.timerForPitch = nil;
}

- (void)playBtnUpInside:(UIButton *)playBtn
{
    if (self.audioPlayer.playing) {
        [self.audioPlayer stop];
        return;
    }
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:self.url error:nil];
    self.audioPlayer = player;
    [self.audioPlayer play];
}

- (void)audioRecordSetting
{
    self.recordSettings = [[NSMutableDictionary alloc] initWithCapacity:10];
    if(self.recordEncoding == ENC_PCM)
    {
        [self.recordSettings setObject:[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey: AVFormatIDKey];
        [self.recordSettings setObject:[NSNumber numberWithFloat:44100.0] forKey: AVSampleRateKey];
        [self.recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
        [self.recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [self.recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        [self.recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    } else {
        NSNumber *formatObject;
        switch (self.recordEncoding) {
            case (ENC_AAC):
                formatObject = [NSNumber numberWithInt: kAudioFormatMPEG4AAC];
                break;
            case (ENC_ALAC):
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleLossless];
                break;
            case (ENC_IMA4):
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleIMA4];
                break;
            case (ENC_ILBC):
                formatObject = [NSNumber numberWithInt: kAudioFormatiLBC];
                break;
            case (ENC_ULAW):
                formatObject = [NSNumber numberWithInt: kAudioFormatULaw];
                break;
            default:
                formatObject = [NSNumber numberWithInt: kAudioFormatAppleIMA4];
        }
        
        [self.recordSettings setObject:formatObject forKey: AVFormatIDKey];
        [self.recordSettings setObject:[NSNumber numberWithFloat:44100.0] forKey: AVSampleRateKey];
        [self.recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
        [self.recordSettings setObject:[NSNumber numberWithInt:12800] forKey:AVEncoderBitRateKey];
        [self.recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [self.recordSettings setObject:[NSNumber numberWithInt: AVAudioQualityHigh] forKey: AVEncoderAudioQualityKey];
    }
}

- (void)levelTimerCallback:(NSTimer *)timer
{
    [self.audioRecorder updateMeters];
    
    float linear = pow (10, [self.audioRecorder peakPowerForChannel:0] / 20);
    NSLog(@"linear===%f",linear);
    float linear1 = pow (10, [self.audioRecorder averagePowerForChannel:0] / 20);
    NSLog(@"linear1===%f",linear1);
}

- (void)btnSaveUpInside:(UIButton*)btn
{
    
}

- (void)audioPathSetting
{
    //路径设置
    NSString *documentUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    switch (self.recordType) {
        case 1: {
            self.url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/nameAudio%@.caf", documentUrl,[NSDate date]]];
            break;
        }
        case 2: {
            self.url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/telephoneAudio%@.caf", documentUrl,[NSDate date]]];
            break;
        }
        default: {
            self.url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/addressAudio%@.caf", documentUrl,[NSDate date]]];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
