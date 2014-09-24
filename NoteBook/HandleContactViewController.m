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
#import "UIButton+HB.h"
#import "UIFont+HB.h"
#import "UIView+HB.h"

@interface HandleContactViewController ()<InfoCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

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
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80.0)];
    footerView.backgroundColor = [UIColor clearColor];
    UIButton *saveButton = [UIButton buttonTextColor:[UIColor brownColor] cordius:2.0 boderWidth:1.0];
    saveButton.frame = CGRectMake(0, 10, 280, 40);
    [saveButton setTitle:@"保          存" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont H2Font];
    saveButton.centerX = footerView.centerX;
    [footerView addSubview:saveButton];
    
    self.tableView.tableFooterView = footerView;
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
        [cell.selectDefaultContactImage addTarget:self action:@selector(editDefaultImage:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contactAlbum addTarget:self action:@selector(editDefaultImage:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)recordButtonTapped:(TextAndRecordCell *)cell
{
    NSLog(@"1111111111");
}

- (void)playButtonTapped:(TextAndRecordCell *)cell
{
    NSLog(@"22222222222");
}

- (void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
