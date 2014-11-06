//
//  HandleContactViewController.m
//  NoteBook
//
//  Created by xubing on 14-9-18.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "HandleContactViewController.h"
#import "Contact.h"
#import "AppDelegate.h"
#import "AGIPCToolbarItem.h"
#import "ImageCropperViewController.h"
#import "RecordAndPlayViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "TextAndRecordCell.h"
#import "ContactImageCell.h"
#import "UIImageView+HB.h"
#import "UIButton+HB.h"
#import "UIFont+HB.h"
#import "UIView+HB.h"

@interface HandleContactViewController ()<InfoCellDelegate, ImageCropperDelegate, RecordFinishRelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIActionSheetDelegate,UIImagePickerControllerDelegate, AGImagePickerControllerDelegate, UINavigationControllerDelegate,AVAudioPlayerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) Contact *contact;
@property (nonatomic, strong) AppDelegate *myDelegate;
@property (nonatomic, strong) AGImagePickerController *ipc;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *textFieldInfo;
@property (nonatomic, strong) NSString *defaultImagePathString;

@property (nonatomic, strong) NSURL *nameAudioUrl;
@property (nonatomic, strong) NSURL *telephoneAudioUrl;
@property (nonatomic, strong) NSURL *addressAudioUrl;

@property (nonatomic, strong) NSString *namePathString;
@property (nonatomic, strong) NSString *telephonePathString;
@property (nonatomic, strong) NSString *addressPathString;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic) BOOL edittedImage;
@property (nonatomic, strong) UIImage *defaultImage;

@end

@implementation HandleContactViewController

- (void)editAlbumInitial
{
    self.selectedPhotos = [NSMutableArray array];
    __block HandleContactViewController *blockSelf = self;
    self.ipc = [[AGImagePickerController alloc] initWithDelegate:self];
    self.ipc.didFailBlock = ^(NSError *error) {
        NSLog(@"Fail. Error: %@", error);
        if (error == nil) {
            [blockSelf.selectedPhotos removeAllObjects];
            NSLog(@"User has cancelled.");
            [blockSelf dismissViewControllerAnimated:YES completion:NULL];
        } else {
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [blockSelf dismissViewControllerAnimated:YES completion:NULL];
            });
        }
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        
    };
    self.ipc.didFinishBlock = ^(NSArray *info) {
        [blockSelf.selectedPhotos setArray:info];
        NSLog(@"Info: %@", info);
        [blockSelf dismissViewControllerAnimated:YES completion:NULL];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    };
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleViewWithString:@"添加联系人"];
    
    //获取当前应用程序的委托（UIApplication sharedApplication为整个应用程序上下文）
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self editAlbumInitial];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250.0)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIScrollView *albumImages = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    for (int i = 0; i < 3; i++) {
        UIImageView *contactImage = [UIImageView imageViewCordius:5.0];
        contactImage.frame = CGRectMake(100 * i + 10, 10, 90, 90);
        [albumImages addSubview:contactImage];
    }
    [footerView addSubview:albumImages];
    
    UIButton *contactAlbum = [UIButton buttonTextColor:[UIColor brownColor] cordius:2.0 boderWidth:1.0];
    contactAlbum.frame = CGRectMake(20, 110, ScreenWidth - 40, 40);
    [contactAlbum setTitle:@"编 辑 相 册" forState:UIControlStateNormal];
    contactAlbum.titleLabel.font = [UIFont H2Font];
    [contactAlbum addTarget:self action:@selector(editAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:contactAlbum];
    
    UIView *line = [UIView lineViewWithXoff:5 color:[UIColor GrayLine1Color] height:0.5];
    line.top = contactAlbum.bottom + 10;
    [footerView addSubview:line];
    
    UIButton *saveButton = [UIButton buttonNomalColor:[UIColor brownColor] highLightColor:[UIColor redColor] coRadius:2.0];
    saveButton.frame = CGRectMake(0, 170, 280, 50);
    [saveButton setTitle:@"保 存 联 系 人" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont H2Font];
    saveButton.centerX = footerView.centerX;
    [footerView addSubview:saveButton];
    
    self.tableView.tableFooterView = footerView;
    
    self.textFieldInfo = [NSMutableArray arrayWithArray:@[@[@""],@[@"10"],@[@"20"],@[@"30"]]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight;
    switch (indexPath.section) {
        case 0:
            cellHeight = 170.0;
            break;
        default:
            cellHeight = 128.0;
            break;
    }
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ContactImageCell *cell = [[ContactImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell showBottonLineWithCellHeight:170.0 andOffsetX:5.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.edittedImage) {
            cell.defaultContactImage.image = self.defaultImage;
        }
        
        [cell.selectDefaultContactImage addTarget:self action:@selector(editDefaultImage:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else {
        TextAndRecordCell *cell = [[TextAndRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell showBottonLineWithCellHeight:128.0 andOffsetX:5.0];
        switch (indexPath.section) {
            case 1:
                cell.infoLabel.text = @"姓名:";
                break;
            case 2:
                cell.infoLabel.text = @"电话:";
                cell.infoTextField.keyboardType = UIKeyboardTypeDecimalPad;
                break;
            case 3:
                cell.infoLabel.text = @"地址:";
                break;
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.infoTextField.delegate = self;
        cell.infoTextField.tag = indexPath.section * 10 + indexPath.row;
        [cell configCellWithText:self.textFieldInfo[indexPath.section][indexPath.row]];
        cell.delegate = self;
        return cell;
    }
}

#pragma mark - editDefaultImage
- (void)editDefaultImage:(UIButton *)btn {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"设置默认头像"
                                                             delegate:self
                                                    cancelButtonTitle:@"取                     消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"相    机    拍    照",@"相    册    选    择",nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
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
    //set the path of defaultImageUrl
    NSString *defaultImageUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *defaultImageDisplayUrl;
    defaultImageDisplayUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/defaultImage%@.png", defaultImageUrl,[NSDate date]]];
    NSData *imageData = UIImagePNGRepresentation(editedImage);
    [imageData writeToURL:defaultImageDisplayUrl atomically:YES];
    self.defaultImagePathString = [defaultImageDisplayUrl absoluteString];
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        self.edittedImage = YES;
        self.defaultImage = editedImage;
        NSIndexPath *rowToReload = [NSIndexPath indexPathForRow:0 inSection:0];
        NSArray *rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
        [self.tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:YES];
    }];
}

- (void)imageCropperDidCancel:(ImageCropperViewController *)cropperViewController
{
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

- (BOOL) isPhotoLibraryAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) canUserPickPhotosFromPhotoLibrary
{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType
{
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
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage
{
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

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize
{
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

#pragma mark - editAlbum
- (void)editAlbum:(UIButton *)btn
{
    // Show saved photos on top
    self.ipc.shouldShowSavedPhotosOnTop = YES;
    self.ipc.shouldChangeStatusBarStyle = YES;
    self.ipc.selection = self.selectedPhotos;
    
    // Custom toolbar items
    AGIPCToolbarItem *selectAll = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"+ 选 择 全 部" style:UIBarButtonItemStyleBordered target:nil action:nil] andSelectionBlock:^BOOL(NSUInteger index, ALAsset *asset) {
        return YES;
    }];
    AGIPCToolbarItem *flexible = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] andSelectionBlock:nil];
    
    AGIPCToolbarItem *deselectAll = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"- 全 部 不 选" style:UIBarButtonItemStyleBordered target:nil action:nil] andSelectionBlock:^BOOL(NSUInteger index, ALAsset *asset) {
        return NO;
    }];
    self.ipc.toolbarItemsForManagingTheSelection = @[selectAll,  flexible, deselectAll];
    NSLog(@"successed");
    [self presentViewController:self.ipc animated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - AGImagePickerControllerDelegate methods
- (NSUInteger)agImagePickerController:(AGImagePickerController *)picker
         numberOfItemsPerRowForDevice:(AGDeviceType)deviceType
              andInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
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

#pragma mark record
- (void)doFinishRecordWithUrl:(NSURL *)url tag:(NSInteger)i
{
    switch (i) {
        case 1:
        {
            self.nameAudioUrl = url;
            self.namePathString = [url absoluteString];
            break;
        }
        
        case 2:
        {
            self.telephoneAudioUrl = url;
            self.telephonePathString = [url absoluteString];
            break;
        }
        case 3:
        {
            self.addressAudioUrl = url;
            self.addressPathString = [url absoluteString];
            break;
        }
        default:
            break;
    }
}

- (void)recordButtonTapped:(TextAndRecordCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    RecordAndPlayViewController *recordVC = [[RecordAndPlayViewController alloc] init];
    recordVC.recordDelegate = self;
    recordVC.recordType = indexPath.section;
    [self.navigationController pushViewController:recordVC animated:YES];
}

- (void)playButtonTapped:(TextAndRecordCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSURL *url;
    switch (indexPath.section) {
        case 1:
            url = self.nameAudioUrl;
            break;
        case 2:
            url = self.telephoneAudioUrl;
            break;
        case 3:
            url = self.addressAudioUrl;
            break;
        default:
            break;
    }
    if (self.audioPlayer.playing) {
        [self.audioPlayer stop];
        return;
    }
    
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [self.audioPlayer play];
}

- (void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.tableView endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag / 10) {
        case 1:
            [(NSMutableArray *)self.textFieldInfo[1] replaceObjectAtIndex:textField.tag % 10 withObject:textField.text];
            break;
        case 2:
            [(NSMutableArray *)self.textFieldInfo[2] replaceObjectAtIndex:textField.tag % 10 withObject:textField.text];
            break;
        case 3:
            [(NSMutableArray *)self.textFieldInfo[3] replaceObjectAtIndex:textField.tag % 10 withObject:textField.text];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
