//
//  AddViewController.m
//  NoteBook
//
//  Created by xubing on 14-1-13.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "AddViewController.h"
#import "AGIPCToolbarItem.h"
#import "Contact.h"
#import "ImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface AddViewController ()<ImageCropperDelegate> {
    AGImagePickerController *ipc;
}

@end

@implementation AddViewController {
    CGFloat labelWidth;
    CGFloat labelHeight;
    CGFloat buttonWidth;
    CGFloat buttonHeight;
    CGFloat fieldWidth;
    CGFloat fieldHeight;
    NSInteger recordTag;
    NSString *defaultImagePathString;
    NSString *namePathString;
    NSString *telephonePathString;
    NSString *addressPathString;
}

@synthesize selectedPhotos;

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        [self editAlbumInitial];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取当前应用程序的委托（UIApplication sharedApplication为整个应用程序上下文）
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.scrollViewMain = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.scrollViewMain.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.scrollViewMain];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.scrollViewMain addGestureRecognizer:tapGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    
    UIView *viewImageScope = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 170)];
    [self.scrollViewMain addSubview:viewImageScope];
    
    self.imageViewPhoto = [[UIImageView alloc] initWithFrame:(CGRectMake(20, 2, 150, 150))];
    self.imageViewPhoto.layer.cornerRadius = 15.0f;
    self.imageViewPhoto.layer.masksToBounds = YES;
    if (self.editContact) {
        self.imageViewPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.contact.defaultImagePath]]];
    }
    else{
        self.imageViewPhoto.image = [UIImage imageNamed:@"08.png"];
    };
    [viewImageScope addSubview:self.imageViewPhoto];

    
    UIButton *buttonSetPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonSetPhoto.frame = CGRectMake(190, 20, ScreenWidth - 210, 50);
    [buttonSetPhoto setTitle:@"设 置 头 像" forState:(UIControlStateNormal)];
    [buttonSetPhoto addTarget:self action:@selector(editDefaultImage:) forControlEvents:UIControlEventTouchUpInside];
    [viewImageScope addSubview:buttonSetPhoto];
    
    UIButton *buttonAddPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonAddPhoto.frame = CGRectMake(190, 90, ScreenWidth - 210, 50);
    [buttonAddPhoto setTitle:@"编 辑 相 册" forState:(UIControlStateNormal)];
    [buttonAddPhoto addTarget:self action:@selector(editAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [viewImageScope addSubview:buttonAddPhoto];
    
    UIView *viewImageLine = [[UIView alloc] initWithFrame:CGRectMake(10, 165, ScreenWidth-20, 1)];
    viewImageLine.backgroundColor = [UIColor grayColor];
    [viewImageScope addSubview:viewImageLine];


    UIView *viewNameScope = [[UIView alloc] initWithFrame:CGRectMake(0, 180, ScreenWidth, 128)];
    [self.scrollViewMain addSubview:viewNameScope];
    
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 0, 0)];
    labelName.text = @"姓       名:";
    [labelName sizeToFit];
    [viewNameScope addSubview:labelName];
    
    labelWidth = labelName.frame.size.width;
    labelHeight = labelName.frame.size.height;
    fieldWidth = ScreenWidth - labelWidth - 80;
    fieldHeight = labelName.frame.size.height + 20;
    
    self.textFieldName = [[UITextField alloc] initWithFrame:(CGRectMake(30 + labelWidth + 20, 10, fieldWidth, fieldHeight))];
    self.textFieldName.borderStyle=UITextBorderStyleRoundedRect;
    self.textFieldName.delegate = self;
    if (self.editContact) {
        self.textFieldName.text = self.contact.name;
    }
    [viewNameScope addSubview:self.textFieldName];
    
    UILabel *labelNameAudio = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 0, 0)];
    labelNameAudio.text = @"背景音效:";
    [labelNameAudio sizeToFit];
    [viewNameScope addSubview:labelNameAudio];
    
    buttonWidth = (ScreenWidth - labelWidth - 100)/2;
    buttonHeight = labelName.frame.size.height + 20;
    
    UIButton *buttonNameRecord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonNameRecord.frame = CGRectMake(30 + labelWidth + 20, 70, buttonWidth, buttonHeight);
    [buttonNameRecord setTitle:@"录  音" forState:(UIControlStateNormal)];
    [buttonNameRecord addTarget:self action:@selector(nameBtnUpInside:)  forControlEvents:UIControlEventTouchUpInside];
    [viewNameScope addSubview:buttonNameRecord];
    
    UIButton *buttonNamePlay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonNamePlay.frame = CGRectMake(30 + labelWidth + buttonWidth + 40, 70, buttonWidth, buttonHeight);
    [buttonNamePlay setTitle:@"播  放" forState:(UIControlStateNormal)];
    [buttonNamePlay addTarget:self action:@selector(nameBoFangBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [viewNameScope addSubview:buttonNamePlay];
    
    UIView *viewNameLine = [[UIView alloc] initWithFrame:CGRectMake(10, 125, ScreenWidth-20, 1)];
    viewNameLine.backgroundColor = [UIColor grayColor];
    [viewNameScope addSubview:viewNameLine];
    
    
    
    UIView *viewTeleScope = [[UIView alloc] initWithFrame:CGRectMake(0, 310, ScreenWidth, 128)];
    [self.scrollViewMain addSubview:viewTeleScope];
    
    UILabel *labelTele = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 0, 0)];
    labelTele.text = @"电       话:";
    [labelTele sizeToFit];
    [viewTeleScope addSubview:labelTele];
    
    self.textFieldTelephone = [[UITextField alloc] initWithFrame:(CGRectMake(30 + labelWidth + 20, 10, fieldWidth, fieldHeight))];
    self.textFieldTelephone.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldTelephone.delegate = self;
    if (self.editContact) {
        self.textFieldTelephone.text = self.contact.telephoneNumber;
    }
    self.textFieldTelephone.keyboardType = UIKeyboardTypeDecimalPad;
    [viewTeleScope addSubview:self.textFieldTelephone];
    
    UILabel *labelTeleAudio = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 0, 0)];
    labelTeleAudio.text = @"背景音效:";
    [labelTeleAudio sizeToFit];
    [viewTeleScope addSubview:labelTeleAudio];
    
    UIButton *buttonTeleRecord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonTeleRecord.frame = CGRectMake(30 + labelWidth + 20, 70, buttonWidth, buttonHeight);
    [buttonTeleRecord setTitle:@"录  音" forState:(UIControlStateNormal)];
    [buttonTeleRecord addTarget:self action:@selector(telephoneBtnUpInside:)  forControlEvents:UIControlEventTouchUpInside];
    [viewTeleScope addSubview:buttonTeleRecord];
    
    UIButton *buttonTelePlay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonTelePlay.frame = CGRectMake(30 + labelWidth + buttonWidth + 40, 70, buttonWidth, buttonHeight);
    [buttonTelePlay setTitle:@"播  放" forState:(UIControlStateNormal)];
    [buttonTelePlay addTarget:self action:@selector(telephoneBoFangBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [viewTeleScope addSubview:buttonTelePlay];
    
    UIView *viewTeleLine = [[UIView alloc] initWithFrame:CGRectMake(10, 125, ScreenWidth-20, 1)];
    viewTeleLine.backgroundColor = [UIColor grayColor];
    [viewTeleScope addSubview:viewTeleLine];
    
    UIView *viewAddressScope = [[UIView alloc] initWithFrame:CGRectMake(0, 440, ScreenWidth, 128)];
    [self.scrollViewMain addSubview:viewAddressScope];
    
    
    UILabel *labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 0, 0)];
    labelAddress.text = @"地       址:";
    [labelAddress sizeToFit];
    [viewAddressScope addSubview:labelAddress];
    
    self.textFieldAddress = [[UITextField alloc] initWithFrame:(CGRectMake(30 + labelWidth + 20, 10, fieldWidth, fieldHeight))];
    self.textFieldAddress.borderStyle=UITextBorderStyleRoundedRect;
    self.textFieldAddress.delegate = self;
    if (self.editContact) {
        self.textFieldAddress.text = self.contact.address;
    }
    [viewAddressScope addSubview:self.textFieldAddress];
    
    UILabel *labelAddressAudio = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 0, 0)];
    labelAddressAudio.text = @"背景音效:";
    [labelAddressAudio sizeToFit];
    [viewAddressScope addSubview:labelAddressAudio];
    
    UIButton *buttonAddressRecord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonAddressRecord.frame = CGRectMake(30 + labelWidth + 20, 70, buttonWidth, buttonHeight);
    [buttonAddressRecord setTitle:@"录  音" forState:(UIControlStateNormal)];
    [buttonAddressRecord addTarget:self action:@selector(addressBtnUpInside:)  forControlEvents:UIControlEventTouchUpInside];
    [viewAddressScope addSubview:buttonAddressRecord];
    
    UIButton *buttonAddressPlay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonAddressPlay.frame = CGRectMake(30 + labelWidth + buttonWidth + 40, 70, buttonWidth, buttonHeight);
    [buttonAddressPlay setTitle:@"播  放" forState:(UIControlStateNormal)];
    [buttonAddressPlay addTarget:self action:@selector(addressBoFangBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [viewAddressScope addSubview:buttonAddressPlay];
    
    UIView *viewAddressLine = [[UIView alloc] initWithFrame:CGRectMake(10, 125, ScreenWidth-20, 1)];
    viewAddressLine.backgroundColor = [UIColor grayColor];
    [viewAddressScope addSubview:viewAddressLine];
    
    
    UIButton *buttonSave = [UIButton buttonWithType:UIButtonTypeInfoLight];
    buttonSave.frame = CGRectMake(20, 600, ScreenWidth - 40, buttonHeight + 10);
    buttonSave.backgroundColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.8 alpha:0.9];
    [buttonSave setTitle:@"保                            存" forState:(UIControlStateNormal)];
    [buttonSave addTarget:self action:@selector(saveContactUpInSide:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewMain addSubview:buttonSave];
    
    self.viewRecord = [[UIView alloc] initWithFrame:CGRectMake(0, -640, ScreenWidth, ScreenHeight)];
    self.viewRecord.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
    [self.scrollViewMain addSubview:self.viewRecord];
    
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
    
    self.doRecord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.doRecord.frame = CGRectMake(60, 300, 200, 50);
    [self.doRecord setTitle:@"开      始      录      音" forState:(UIControlStateNormal)];
    [self.doRecord addTarget:self action:@selector(recordBtnDown:) forControlEvents:UIControlEventTouchDown];
    [self.doRecord addTarget:self action:@selector(recordBtnDragUp:) forControlEvents:UIControlEventTouchDragOutside];
    [self.doRecord addTarget:self action:@selector(recordBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewRecord addSubview:self.doRecord];
    
    self.doTry = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.doTry.frame = CGRectMake(60, 365, 200, 50);
    [self.doTry setTitle:@"试      听      录      音" forState:(UIControlStateNormal)];
    [self.doTry addTarget:self action:@selector(playBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewRecord addSubview:self.doTry];
    
    self.confirm = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.confirm.frame = CGRectMake(60, 430, 200, 50);
    [self.confirm setTitle:@"确      认      保      存" forState:(UIControlStateNormal)];
    [self.confirm addTarget:self action:@selector(btnSaveUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewRecord addSubview:self.confirm];

    
    self.defaultImageDisplay = [[UIView alloc] initWithFrame:CGRectMake(0, -640, ScreenWidth, ScreenHeight)];
    self.defaultImageDisplay.backgroundColor = [UIColor grayColor];
    [self.scrollViewMain addSubview:self.defaultImageDisplay];
    
    self.defaultImageShow = [[UIImageView alloc] initWithFrame:CGRectMake(.5, (ScreenHeight - ScreenWidth) / 2 - 32, ScreenWidth, ScreenWidth)];
    self.defaultImageShow.image = self.imageViewPhoto.image;
    [self.defaultImageDisplay addSubview:self.defaultImageShow];
    
    UITapGestureRecognizer *imageTapRecognizer = [[UITapGestureRecognizer alloc]
                                                  initWithTarget:self action:@selector(defaultImageTapped)];
    imageTapRecognizer.numberOfTapsRequired = 1;
    [self.imageViewPhoto addGestureRecognizer:imageTapRecognizer];
    self.imageViewPhoto.userInteractionEnabled = YES;

    
    self.scrollViewMain.contentSize = CGSizeMake(ScreenWidth,750);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - editDefaultImage
-(void)editDefaultImage:(UIButton *)btn {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"设置默认头像"
                                                             delegate:self
                                                    cancelButtonTitle:@"取                     消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"相    机    拍    照",@"相    册    选    择",nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 相机拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 
                             }];
        }
    }
}

#pragma mark - ImageCropperControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        ImageCropperViewController *imgEditorVC = [[ImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
        }];
    }];
}

- (void)imageCropper:(ImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.imageViewPhoto.image = editedImage;
    self.defaultImageShow.image = editedImage;
    //set the path of defaultImageUrl
    NSString *defaultImageUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *defaultImageDisplayUrl;
    defaultImageDisplayUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/defaultImage%@.png", defaultImageUrl,[NSDate date]]];
    NSData *imageData = UIImagePNGRepresentation(editedImage);
    [imageData writeToURL:defaultImageDisplayUrl atomically:YES];
    defaultImagePathString = [defaultImageDisplayUrl absoluteString];
    self.edittedImage = YES;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imageCropperDidCancel:(ImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark camera utility
- (BOOL) isCameraAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable {
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) canUserPickPhotosFromPhotoLibrary {
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType {
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ScreenWidth) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ScreenWidth;
        btWidth = sourceImage.size.width * (ScreenWidth / sourceImage.size.height);
    } else {
        btWidth = ScreenWidth;
        btHeight = sourceImage.size.height * (ScreenWidth / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;
        } else {
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        }
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}



#pragma mark - recordTag
-(void)nameBtnUpInside:(UIButton *)btn {
    recordTag = 1;
    self.edittedNameAudio = YES;
    [self audioPathSetting];
    self.viewRecord.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
}

-(void)telephoneBtnUpInside:(UIButton *)btn {
    recordTag = 2;
    self.edittedTelephoneAudio = YES;
    [self audioPathSetting];
    self.viewRecord.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
}

-(void)addressBtnUpInside:(UIButton *)btn {
    recordTag = 3;
    self.edittedAdressAudio = YES;
    [self audioPathSetting];
    self.viewRecord.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
}

- (void)audioPathSetting {
    //路径设置
    NSString *documentUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    switch (recordTag) {
        case 1: {
            nameAudioUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/nameAudio%@.aac", documentUrl,[NSDate date]]];
            urlPlay = nameAudioUrl;
            namePathString = [nameAudioUrl absoluteString];
            break;
        }
        case 2: {
            telephoneAudioUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/telephoneAudio%@.aac", documentUrl,[NSDate date]]];
            urlPlay = telephoneAudioUrl;
            telephonePathString = [telephoneAudioUrl absoluteString];
            break;
        }
        default: {
            addressAudioUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/addressAudio%@.aac", documentUrl,[NSDate date]]];
            urlPlay = addressAudioUrl;
            addressPathString = [addressAudioUrl absoluteString];
            break;
        }
    }
    NSLog(@"urlPlay is:  %@",urlPlay);
}

#pragma mark -audioSetting
- (void)audioRecord {
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init] ;
    //设置录音格式
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数
    [recordSetting setValue:[NSNumber numberWithInt:64] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    //开启音量检测
    recorder.meteringEnabled = YES;
    recorder.delegate = self;
    [self audioPathSetting];
    //初始化
    NSError *error;
    recorder = [[AVAudioRecorder alloc]initWithURL:urlPlay settings:recordSetting error:&error];
}

- (void)detectionVoice {
    [recorder updateMeters];//刷新音量数据
    double lowPassResults = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
    NSLog(@"%lf",lowPassResults);
   
    if (0<lowPassResults<=0.06) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_01.png"]];
    } else if (0.06<lowPassResults<=0.12) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_02.png"]];
    } else if (0.12<lowPassResults<=0.18) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_03.png"]];
    } else if (0.18<lowPassResults<=0.24) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_04.png"]];
    } else if (0.24<lowPassResults<=0.30) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_05.png"]];
    } else if (0.30<lowPassResults<=0.36) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_06.png"]];
    } else if (0.36<lowPassResults<=0.42) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_07.png"]];
    } else if (0.42<lowPassResults<=0.48) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_08.png"]];
    } else if (0.48<lowPassResults<=0.54) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_09.png"]];
    } else if (0.54<lowPassResults<=0.60) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_10.png"]];
    } else if (0.60<lowPassResults<=0.66) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_11.png"]];
    } else if (0.66<lowPassResults<=0.72) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_12.png"]];
    } else if (0.72<lowPassResults<=0.9) {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_13.png"]];
    } else {
        [self.imageViewRecorder setImage:[UIImage imageNamed:@"record_animate_14.png"]];
    }
}

#pragma mark - recordAudio
-(void)recordBtnDown:(UIButton *)recordBtn {
    [self.doRecord setTitle:@"正      在      录      音" forState:UIControlStateNormal];
    //创建录音文件，准备录音
    [self audioRecord];
    if ([recorder prepareToRecord]) {
        //开始录音
        [recorder record];
    }
    //设置定时检测
    timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
}

-(void)recordBtnUpInside:(UIButton *)recordBtn {
    [self.doRecord setTitle:@"开      始      录      音" forState:UIControlStateNormal];
    double cTime = recorder.currentTime;
    if (1 < cTime < 180 ) {
        //如果录制时间在1s到120s之间，则保存录音数据
        [recorder stop];
        NSLog(@"已保存");
    } else {
        //删除记录的文件
        [recorder stop];
        [recorder deleteRecording];
        NSLog(@"因录制的音频不符合条件，已删除");
    }
    [timer invalidate];
}

-(void)recordBtnDragUp:(UIButton *)recordBtn {
    //删除录制文件
    [recorder stop];
    [recorder deleteRecording];
    [timer invalidate];
    NSLog(@"取消发送");
}

#pragma  mark - playAudio
- (NSURL *)chooseUrl {
    NSURL *url;
    switch (recordTag) {
        case 1:{
            url = nameAudioUrl;
            break;
            }
        case 2:{
            url = telephoneAudioUrl;
            break;
        }
        default:{
            url = addressAudioUrl;
            break;
        }
    }
    return url;
}

- (NSURL *)chooseContactUrl {
    NSURL *url;
        switch (recordTag) {
        case 1:{
            if (self.edittedNameAudio) {
                url = nameAudioUrl;
            }
            else{
                url = [NSURL URLWithString:self.contact.nameAudioPath];
            }
            break;
        }
        case 2:{
            if (self.edittedTelephoneAudio) {
                url = telephoneAudioUrl;
            }
            else{
                url = [NSURL URLWithString:self.contact.telephoneNumberAudioPath];
            }
            break;
        }
        default:{
            if (self.edittedAdressAudio) {
                url = addressAudioUrl;
            }
            else{
                url = [NSURL URLWithString:self.contact.addressAudioPath];
            }
            break;
        }
    }
    return url;
}

- (void)playBtnUpInside:(UIButton *)playBtn {
    if (self.avPlay.playing) {
        [self.avPlay stop];
        return;
    }
    if (self.editContact) {
        AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:[self chooseContactUrl] error:nil];
        self.avPlay = player;
        [self.avPlay play];
    } else {
        AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:[self chooseUrl] error:nil];
        self.avPlay = player;
        [self.avPlay play];
    }
}

#pragma mark - boFangAudio
- (void)nameBoFangBtnUpInside:(UIButton *)btn {
    recordTag = 1;
    [self playBtnUpInside:Nil];
}

- (void)telephoneBoFangBtnUpInside:(UIButton *)btn {
    recordTag = 2;
    [self playBtnUpInside:Nil];
}

- (void)addressBoFangBtnUpInside:(UIButton *)btn {
    recordTag = 3;
    [self playBtnUpInside:Nil];
}

#pragma mark - saveAudioRecord
- (void)btnSaveUpInside:(UIButton*)btn {
    self.viewRecord.frame = CGRectMake(0, -640, ScreenWidth, ScreenHeight);
}

#pragma mark - Core Data
- (void)saveContactUpInSide:(UIButton *)btn {
    //让CoreData在上下文中创建一个新对象(托管对象)
    Contact *contacter = nil;
    if (!self.editContact) {
        contacter = (Contact *)[NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:self.myDelegate.managedObjectContext];
    } else {
        contacter = self.contact;
    }
    
    [contacter setName:self.textFieldName.text];
    [contacter setTelephoneNumber:self.textFieldTelephone.text];
    [contacter setAddress:self.textFieldAddress.text];
   
    if (self.editContact) {
        if (self.edittedImage) {
            [contacter setDefaultImagePath:defaultImagePathString];
        } else {
            [contacter setDefaultImagePath:self.contact.defaultImagePath];
        }
    } else {
        [contacter setDefaultImagePath:defaultImagePathString];
    }
    
    if (self.editContact) {
        if (self.edittedNameAudio) {
            [contacter setNameAudioPath:namePathString];
        } else {
        [contacter setNameAudioPath:self.contact.nameAudioPath];
        }
    } else {
        [contacter setNameAudioPath:namePathString];
    }

    if (self.editContact) {
        if (self.edittedTelephoneAudio) {
            [contacter setTelephoneNumberAudioPath:telephonePathString];
        } else {
        [contacter setTelephoneNumberAudioPath:self.contact.telephoneNumberAudioPath];
        }
    } else {
        [contacter setTelephoneNumberAudioPath:telephonePathString];
    }

    if (self.editContact) {
        if (self.edittedAdressAudio) {
            [contacter setAddressAudioPath:addressPathString];
        } else {
        [contacter setAddressAudioPath:self.contact.addressAudioPath];
        }
    } else {
        [contacter setAddressAudioPath:addressPathString];
    }
    
    [contacter setCreatDate:[NSDate date]];
    
    NSError *error;
    
    //托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
    BOOL isSaveSuccess = [self.myDelegate.managedObjectContext save:&error];
    
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    } else {
        NSLog(@"Save successful!");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - editAlbum
- (void)editAlbum:(UIButton *)btn {
    // Show saved photos on top
    ipc.shouldShowSavedPhotosOnTop = YES;
    ipc.shouldChangeStatusBarStyle = YES;
    ipc.selection = self.selectedPhotos;
    
    // Custom toolbar items
    AGIPCToolbarItem *selectAll = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"+ 选 择 全 部" style:UIBarButtonItemStyleBordered target:nil action:nil] andSelectionBlock:^BOOL(NSUInteger index, ALAsset *asset) {
        return YES;
    }];
    AGIPCToolbarItem *flexible = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] andSelectionBlock:nil];
    
    AGIPCToolbarItem *deselectAll = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"- 全 部 不 选" style:UIBarButtonItemStyleBordered target:nil action:nil] andSelectionBlock:^BOOL(NSUInteger index, ALAsset *asset) {
        return NO;
    }];
    ipc.toolbarItemsForManagingTheSelection = @[selectAll,  flexible, deselectAll];
    NSLog(@"successed");
    [self presentViewController:ipc animated:YES completion:NULL];
}

-(void)editAlbumInitial {
    self.selectedPhotos = [NSMutableArray array];
    __block AddViewController *blockSelf = self;
    ipc = [[AGImagePickerController alloc] initWithDelegate:self];
    ipc.didFailBlock = ^(NSError *error) {
        NSLog(@"Fail. Error: %@", error);
        if (error == nil) {
            [blockSelf.selectedPhotos removeAllObjects];
            NSLog(@"User has cancelled.");
            [blockSelf dismissViewControllerAnimated:YES completion:NULL];
        } else {
            // We need to wait for the view controller to appear first.
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [blockSelf dismissViewControllerAnimated:YES completion:NULL];
            });
        }
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        
    };
    ipc.didFinishBlock = ^(NSArray *info) {
        [blockSelf.selectedPhotos setArray:info];
        NSLog(@"Info: %@", info);
        [blockSelf dismissViewControllerAnimated:YES completion:NULL];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    };
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - AGImagePickerControllerDelegate methods
- (NSUInteger)agImagePickerController:(AGImagePickerController *)picker
         numberOfItemsPerRowForDevice:(AGDeviceType)deviceType
              andInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (deviceType == AGDeviceTypeiPad) {
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
            return 7;
        } else {
            return 6;
        }
    } else {
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
            return 5;
        } else {
            return 4;
        }
    }
}

- (BOOL)agImagePickerController:(AGImagePickerController *)picker shouldDisplaySelectionInformationInSelectionMode:(AGImagePickerControllerSelectionMode)selectionMode {
    return (selectionMode == AGImagePickerControllerSelectionModeSingle ? NO : YES);
}

- (BOOL)agImagePickerController:(AGImagePickerController *)picker shouldShowToolbarForManagingTheSelectionInSelectionMode:(AGImagePickerControllerSelectionMode)selectionMode {
    return (selectionMode == AGImagePickerControllerSelectionModeSingle ? NO : YES);
}

- (AGImagePickerControllerSelectionBehaviorType)selectionBehaviorInSingleSelectionModeForAGImagePickerController:(AGImagePickerController *)picker {
    return AGImagePickerControllerSelectionBehaviorTypeRadio;
}

#pragma mark - textFieldDelegate
- (void)keyboardHide:(UITapGestureRecognizer*)tap {
    [self.textFieldName resignFirstResponder];
    [self.textFieldTelephone resignFirstResponder];
    [self.textFieldAddress resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.currentView = textField;
    [self keyboardWillShow];
    return YES;
}

- (void)keyboardWillShow {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.scrollViewMain.contentOffset = CGPointMake(0 ,self.currentView.frame.origin.y + self.currentView.superview.frame.origin.y-120);
    [UIView commitAnimations];    
}

-(void)keyboardDidHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)defaultImageTapped {
    [UIView animateWithDuration:0.3 animations:^{
        self.defaultImageDisplay.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }];
}

@end
