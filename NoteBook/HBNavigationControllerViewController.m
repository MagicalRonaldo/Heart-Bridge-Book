//
//  HBNavigationControllerViewController.m
//  NoteBook
//
//  Created by xubing on 14-9-5.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "HBNavigationControllerViewController.h"
#import "UIColor+HB.h"
#import "APPManager.h"
#import "UIImage+HB.h"

@interface HBNavigationControllerViewController ()

@end

@implementation HBNavigationControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationBar.translucent = NO;
        if (![APPManager lowThanIOS7]) {
            self.navigationBar.barTintColor = [UIColor orangeColor];
        } else {
            [[UINavigationBar appearance] setBackgroundImage:[UIImage createImageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
