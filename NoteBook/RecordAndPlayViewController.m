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
#import "UIButton+HB.h"
#import "UIFont+HB.h"

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
@property (nonatomic, strong) NSDictionary *recordSettings;
@property (nonatomic, strong) NSURL *url;

@property (nonatomic) int recordEncoding;

@end

@implementation RecordAndPlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.viewRecord = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.viewRecord.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
    [self.view addSubview:self.viewRecord];
    
    self.recordNotes = [[UILabel alloc] initWithFrame:(CGRectMake(20, 20, 280, 20))];
    self.recordNotes.text = @"请注意：您按住按钮进行录音，可以按住不动向上拖拽即放弃本次录音；请语调缓慢以确保录音清晰";
    self.recordNotes.backgroundColor = [UIColor clearColor];
    self.recordNotes.textColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.8 alpha:1];
    self.recordNotes.lineBreakMode = NSLineBreakByWordWrapping;
    self.recordNotes.numberOfLines = 2;
    [self.recordNotes sizeToFit];
    [self.viewRecord addSubview:self.recordNotes];
    
    self.imageViewRecorder = [[UIImageView alloc] initWithFrame:(CGRectMake(60, 80, 200, 200))];
    self.imageViewRecorder.image = [UIImage imageNamed:@"record_animate_01.png"];
    [self.viewRecord addSubview:self.imageViewRecorder];
    
    self.doRecord = [UIButton buttonNomalColor:[UIColor brownColor] highLightColor:[UIColor BlueColor] coRadius:2.0];
    self.doRecord.frame = CGRectMake(60, 320, 200, 50);
    [self.doRecord setTitle:@"开      始      录      音" forState:UIControlStateNormal];
    [self.doRecord addTarget:self action:@selector(recordBtnDown:) forControlEvents:UIControlEventTouchDown];
    [self.doRecord addTarget:self action:@selector(recordBtnDragUp:) forControlEvents:UIControlEventTouchDragOutside];
    [self.doRecord addTarget:self action:@selector(recordBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewRecord addSubview:self.doRecord];
    
    self.doTry = [UIButton buttonNomalColor:[UIColor brownColor] highLightColor:[UIColor BlueColor] coRadius:2.0];
    self.doTry.frame = CGRectMake(60, 385, 200, 50);
    [self.doTry setTitle:@"试      听      录      音" forState:UIControlStateNormal];
    [self.doTry addTarget:self action:@selector(playBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewRecord addSubview:self.doTry];
    
    self.confirm = [UIButton buttonTextColor:[UIColor brownColor] cordius:2.0 boderWidth:1.0];
    self.confirm.frame = CGRectMake(60, 450, 200, 50);
    [self.confirm setTitle:@"确      认      保      存" forState:UIControlStateNormal];
    self.confirm.titleLabel.font = [UIFont H2Font];
    [self.confirm addTarget:self action:@selector(btnSaveUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewRecord addSubview:self.confirm];
}

- (void)recordBtnDown:(UIButton *)recordBtn
{
    [self.audioRecorder deleteRecording];
    self.audioRecorder = nil;
    [self.doRecord setTitle:@"正      在      录      音" forState:UIControlStateNormal];
    
    //设置和路径
    self.recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithFloat: 8000.0], AVSampleRateKey, //采样率
                           [NSNumber numberWithInt: kAudioFormatLinearPCM], AVFormatIDKey,
                           [NSNumber numberWithInt:16], AVLinearPCMBitDepthKey, //采样位数 默认 16
                           [NSNumber numberWithInt: 1], AVNumberOfChannelsKey, //通道的数目
                           [NSNumber numberWithInt: AVAudioQualityMedium], AVEncoderAudioQualityKey, //音频编码质量
                           nil];
    
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error:nil]; //支持播放与录音
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [self audioPathSetting];
    
    NSError *error = nil;
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:self.url settings:self.recordSettings error:&error];
    self.audioRecorder.meteringEnabled = YES;
    if ([self.audioRecorder prepareToRecord]) {
        [self.audioRecorder record];
    }
    self.timerForPitch = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(levelTimerCallback:) userInfo: nil repeats: YES];
}

-(void)recordBtnDragUp:(UIButton *)recordBtn
{
    //删除录制文件
    [self.doRecord setTitle:@"重      新      录      音" forState:UIControlStateNormal];
    if (self.audioRecorder == nil) {
        return;
    }
    
    [self.audioRecorder deleteRecording];
    [self.audioRecorder stop];
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
    [self.timerForPitch invalidate];
    NSLog(@"取消发送");
}

-(void)recordBtnUpInside:(UIButton *)recordBtn
{
    [self.doRecord setTitle:@"重      新      录      音" forState:UIControlStateNormal];
    double cTime = self.audioRecorder.currentTime;
    [self.audioRecorder stop];
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
    if (cTime > 180 || cTime < 0.5) {
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

#pragma mark AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    [[AVAudioSession sharedInstance] setActive:NO error:nil]; //关闭本次音频回话
}

- (void)levelTimerCallback:(NSTimer *)timer
{
    [self.audioRecorder updateMeters];
    
    float linear = pow (10, [self.audioRecorder peakPowerForChannel:0] / 20);
    NSLog(@"linear===%f",linear);
    float linear1 = pow (10, [self.audioRecorder averagePowerForChannel:0] / 20);
    NSLog(@"linear1===%f",linear1);
    
    double lowPassResults = pow(10, (0.05 * [self.audioRecorder peakPowerForChannel:0]));
    NSLog(@"%lf",lowPassResults);
    
    if (0 < lowPassResults <= 0.06) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_01.png"]];
    } else if (0.06 < lowPassResults <= 0.12) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_02.png"]];
    } else if (0.12 < lowPassResults <= 0.18) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_03.png"]];
    } else if (0.18 < lowPassResults <= 0.24) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_04.png"]];
    } else if (0.24 < lowPassResults <= 0.30) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_05.png"]];
    } else if (0.30 < lowPassResults <= 0.36) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_06.png"]];
    } else if (0.36 < lowPassResults <= 0.42) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_07.png"]];
    } else if (0.42 < lowPassResults <= 0.48) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_08.png"]];
    } else if (0.48 < lowPassResults <= 0.54) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_09.png"]];
    } else if (0.54 < lowPassResults <= 0.60) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_10.png"]];
    } else if (0.60 < lowPassResults <= 0.66) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_11.png"]];
    } else if (0.66 < lowPassResults <= 0.72) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_12.png"]];
    } else if (0.72 < lowPassResults <= 0.9) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_13.png"]];
    } else {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_14.png"]];
    }
}

- (void)btnSaveUpInside:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)audioPathSetting
{
    //路径设置
    NSString *fileUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *voicePath = [NSString stringWithFormat:@"%@/Voice", fileUrl];
    if (![[NSFileManager defaultManager] fileExistsAtPath:voicePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:voicePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    switch (self.recordType) {
        case 1: {
            self.url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/nameAudio%@.wav", voicePath,[NSDate date]]];
            break;
        }
        case 2: {
            self.url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/telephoneAudio%@.wav", voicePath,[NSDate date]]];
            break;
        }
        default: {
            self.url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/addressAudio%@.wav", voicePath,[NSDate date]]];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
