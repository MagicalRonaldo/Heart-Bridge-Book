//
//  HandleContactViewController.m
//  NoteBook
//
//  Created by xubing on 14-9-18.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "HandleContactViewController.h"
#import "TextAndRecordCell.h"
#import "ContactImageCell.h"

@interface HandleContactViewController ()

@end

@implementation HandleContactViewController

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
    [self setTitleViewWithString:@"添加联系人"];
    self.navigationController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
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
                break;
            case 3:
                cell.infoLabel.text = @"地址:";
                break;
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.infoTextField.delegate = self;
        return cell;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
