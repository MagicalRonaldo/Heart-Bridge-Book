//
//  ShowViewController.m
//  NoteBook
//
//  Created by xubing on 14-2-19.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "ShowViewController.h"
#import "Contact.h"

@interface ShowViewController () {
    CGFloat labelWidth;
    CGFloat labelHeight;
    NSInteger recordTag;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ShowViewController

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        //init
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
	// Do any additional setup after loading the view.
    self.scrollViewMain = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.scrollViewMain.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.scrollViewMain];
    
    
    UIImageView *imageViewPhoto = [[UIImageView alloc] initWithFrame:(CGRectMake(20, 10, 280, 280))];
    imageViewPhoto.layer.cornerRadius = 15.0f;
    imageViewPhoto.clipsToBounds = YES;
    imageViewPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.contact.defaultImagePath]]];
    [self.scrollViewMain addSubview:imageViewPhoto];
    
    
    UIView *viewNameScope = [[UIView alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth, 44)];
    [self.scrollViewMain addSubview:viewNameScope];
    UITapGestureRecognizer *nameTapRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(nameTapped:)];
    nameTapRecognizer.numberOfTapsRequired = 1;
    [viewNameScope addGestureRecognizer:nameTapRecognizer];
    
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 0, 0)];
    labelName.text = @"姓名:";
    [labelName setFont:[UIFont systemFontOfSize:25]];
    [labelName sizeToFit];
    [viewNameScope addSubview:labelName];
    
    labelWidth = labelName.frame.size.width;
    labelHeight = labelName.frame.size.height;
    
    UILabel *name = [[UILabel alloc] initWithFrame:(CGRectMake(20 + labelWidth + 20, 7, 150, labelHeight))];
    name.text = self.contact.name;
    [name setFont:[UIFont systemFontOfSize:25]];
    [name sizeToFit];
    [viewNameScope addSubview:name];
    
    
    UIView *viewTelephoneScope = [[UIView alloc] initWithFrame:CGRectMake(0, 345, ScreenWidth, 44)];
//    viewTelephoneScope.backgroundColor = [UIColor blueColor];
    [self.scrollViewMain addSubview:viewTelephoneScope];
    UITapGestureRecognizer *telephoneTapRecognizer = [[UITapGestureRecognizer alloc]
                                                      initWithTarget:self action:@selector(telephoneTapped:)];
    telephoneTapRecognizer.numberOfTapsRequired = 1;
    [viewTelephoneScope addGestureRecognizer:telephoneTapRecognizer];
    
    UILabel *labelTelephone = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 0, 0)];
    labelTelephone.text = @"电话:";
    [labelTelephone setFont:[UIFont systemFontOfSize:25]];
    [labelTelephone sizeToFit];
    [viewTelephoneScope addSubview:labelTelephone];
    
    UILabel *telephone = [[UILabel alloc] initWithFrame:(CGRectMake(20 + labelWidth + 20, 7, 150, labelHeight))];
    telephone.text = self.contact.telephoneNumber;
    [telephone setFont:[UIFont systemFontOfSize:25]];
    [telephone sizeToFit];
    [viewTelephoneScope addSubview:telephone];
    
    
    UIView *viewAddressScope = [[UIView alloc] initWithFrame:CGRectMake(0, 390, ScreenWidth, 44)];
//    viewAddressScope.backgroundColor = [UIColor redColor];
    [self.scrollViewMain addSubview:viewAddressScope];
    UITapGestureRecognizer *addressTapRecognizer = [[UITapGestureRecognizer alloc]
                                                      initWithTarget:self action:@selector(addressTapped:)];
    addressTapRecognizer.numberOfTapsRequired = 1;
    [viewAddressScope addGestureRecognizer:addressTapRecognizer];

    
    UILabel *labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 0, 0)];
    labelAddress.text = @"地址:";
    [labelAddress setFont:[UIFont systemFontOfSize:25]];
    [labelAddress sizeToFit];
    [viewAddressScope addSubview:labelAddress];
    
    UILabel *address = [[UILabel alloc] initWithFrame:(CGRectMake(20 + labelWidth + 20, 7, 150, labelHeight))];
    address.text = self.contact.address;
    [address setFont:[UIFont systemFontOfSize:25]];
    [address sizeToFit];
    [viewAddressScope addSubview:address];
    
    UIButton *buttonSave = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonSave.frame = CGRectMake(30, 440, ScreenWidth - 60, 50);
    [buttonSave setTitle:@"查     看     相     册" forState:UIControlStateNormal];
    [self.scrollViewMain addSubview:buttonSave];
    
    self.scrollViewMain.contentSize = CGSizeMake(ScreenWidth,ScreenHeight-64);
}

#pragma  mark - playAudio
- (NSURL *)chooseUrl:(int)tag {
    NSURL *url;
//    Contact *contact = self.dataArray[tag];
    switch (recordTag) {
        case 1:{
            url = [NSURL URLWithString:self.contact.nameAudioPath];
            break;
        }
        case 2:{
            url = [NSURL URLWithString:self.contact.telephoneNumberAudioPath];
            break;
        }
        default:{
            url = [NSURL URLWithString:self.contact.addressAudioPath];
            break;
        }
    }
    return url;
}

#pragma mark - tapGesture
- (void)nameTapped:(UITapGestureRecognizer *)sender {
    int tag = [sender view].tag;
    recordTag = 1;
    [self playAudio:tag];
}

- (void)telephoneTapped:(UITapGestureRecognizer *)sender {
    int tag = [sender view].tag;
    recordTag = 2;
    [self playAudio:tag];
}

- (void)addressTapped:(UITapGestureRecognizer *)sender {
    int tag = [sender view].tag;
    recordTag = 3;
    [self playAudio:tag];
}

- (void)playAudio:(int)tag {
    if (self.avPlay.playing) {
        [self.avPlay stop];
        return;
    }
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:[self chooseUrl:tag] error:nil];
    self.avPlay = player;
    [self.avPlay play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
