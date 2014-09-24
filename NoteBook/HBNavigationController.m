//
//  HBNavigationController.m
//  NoteBook
//
//  Created by xubing on 14-9-5.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "HBNavigationController.h"
#import "UIColor+HB.h"
#import "APPManager.h"
#import "UIImage+HB.h"

@interface HBNavigationController ()

@end

@implementation HBNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationBar.translucent = NO;
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        if (![APPManager lowThanIOS7]) {
            self.navigationBar.barTintColor = [UIColor brownColor];
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
