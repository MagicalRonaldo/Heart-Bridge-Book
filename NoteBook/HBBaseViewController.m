//
//  HBBaseViewController.m
//  NoteBook
//
//  Created by xubing on 14-9-18.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "HBBaseViewController.h"
#import "BaseDeviceInfo.h"

@interface HBBaseViewController ()

@end

@implementation HBBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        if (self.backType == SelectorBackTypePopBack || self.backType == SelectorBackTypePopToRoot) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
        else {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - private UI method
- (void)setTitleViewWithString:(NSString *)titleStr
{ //设置标题栏
    UILabel *lab = [UILabel getTitleView:titleStr];
    self.navigationItem.titleView = lab;
}

- (void)doBack:(id)sender
{
    if (self.backType == SelectorBackTypeDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (self.backType == SelectorBackTypePopBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.backType == SelectorBackTypePopToRoot) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
