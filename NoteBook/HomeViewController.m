//
//  FirstViewController.m
//  NoteBook
//
//  Created by xubing on 14-1-2.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "HomeViewController.h"
#import "Contact.h"
#import "AddViewController.h"
#import "ShowViewController.h"
#import "UIColor+HB.h"

#define ENTITY_NAME @"Contact"
#define SORT_DESCRIPTION_CREATE_DATE @"createDate"
#define CELL_HEIGHT 150.0

#define SYSTEM_BLUE [UIColor colorWithHexString:@"2087fc"]
#define SYSTEM_LIGHT_GRAY [UIColor colorWithHexString:@"999999"]
#define SYSTEM_LIGHT_GRAY_BG [UIColor colorWithHexString:@"EFEFF4"]
#define SYSTEM_LIGHT_GRAY_BG2 [UIColor colorWithHexString:@"eeeeee"]

#define SYSTEM_DARK_GRAY [UIColor colorWithHexString:@"666666"]
#define SYSTEM_GREEN [UIColor colorWithHexString:@"66cc00"]
#define SYSTEM_ORANGE [UIColor colorWithHexString:@"FF6600"]
#define SYSTEM_RED [UIColor colorWithRed:0.99 green:0.24 blue:0.22 alpha:1]

#define SYSTEM_ZZ_RED [UIColor colorWithRed:0.93 green:0.24 blue:0.25 alpha:1]
#define SYSTEM_NAVBAR_DARK_BG [UIColor colorWithHexString:@"252D3B"]
#define SYSTEM_NAVIBAR_COLOR [UIColor colorWithRed:1 green:1 blue:1 alpha:1]
#define SYSTEM_TABBAR_SELECTCOLOR_DARK [UIColor colorWithHexString:@"1a8ff2"]


@interface HomeViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger recordTag;
@property (nonatomic, strong) UITableView *contactTableView;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contactTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    
    self.contactTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contactTableView setDelegate:self];
    [self.contactTableView setDataSource:self];
    self.contactTableView.backgroundColor = [UIColor whiteColor];
    self.contactTableView.rowHeight = CELL_HEIGHT;
    self.contactTableView.showsVerticalScrollIndicator = FALSE;
    [self.contactTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:self.contactTableView];
    
    //设置标题栏
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    lb.backgroundColor = [UIColor clearColor];
    lb.font = [UIFont systemFontOfSize:20];
    lb.text = @"电话本";
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = lb;
    
    UIBarButtonItem *storeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContactInfo)];
    storeButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = storeButton;
    self.navigationController.navigationBar.hidden = NO;
    
    [self.contactTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateContactData];
    [self.contactTableView reloadData];
}

- (void)addContactInfo
{
    AddViewController *addContact = [[AddViewController alloc] init];
    [self.navigationController pushViewController:addContact animated:YES];
}

- (void)updateContactData
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    self.dataArray = [[myDelegate fetchObjectsWithEntity:@"Contact" predicate:nil sort:@"creatDate" ascending:NO] mutableCopy];
    NSLog(@"=== number of items is %lu", (unsigned long)self.dataArray.count);
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifierCell";
    ContactCell *cell;
    
    NSArray *rightBtnarr = [self rightButtons];
    NSArray *leftBtnarr = [self leftButtons];
    
    if (cell == nil) {
        cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier
                                                containingTableView:tableView
                                                 leftUtilityButtons:leftBtnarr
                                                rightUtilityButtons:rightBtnarr];

    }
    
    Contact *contact = self.dataArray[indexPath.row];
    cell.contactName.text = contact.name;
    cell.contactTele.text = contact.telephoneNumber;
    cell.delegate = self;
    cell.contactImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:contact.defaultImagePath]]];
    
    UITapGestureRecognizer *nameTapRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(nameTapped:)];
    nameTapRecognizer.numberOfTapsRequired = 1;
    [cell.contactName addGestureRecognizer:nameTapRecognizer];
    
    UITapGestureRecognizer *telephoneTapRecognizer = [[UITapGestureRecognizer alloc]
                                                      initWithTarget:self action:@selector(telephoneTapped:)];
    telephoneTapRecognizer.numberOfTapsRequired = 1;
    [cell.contactTele addGestureRecognizer:telephoneTapRecognizer];
    
    UITapGestureRecognizer *imageTapRecognizer = [[UITapGestureRecognizer alloc]
                                                  initWithTarget:self action:@selector(contactTapped:)];
    imageTapRecognizer.numberOfTapsRequired = 1;
    [cell.imageView addGestureRecognizer:imageTapRecognizer];
    
    cell.call.tag = indexPath.row;
    cell.imageView.tag = indexPath.row;
    cell.contactName.tag = indexPath.row;
    cell.contactTele.tag = indexPath.row;
    return cell;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray array];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor brownColor] title:@"编辑"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor redColor] title:@"删除"];
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray array];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor brownColor] title:@"分组"];
    return rightUtilityButtons;
}

#pragma mark -SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    self.indexPath = [self.contactTableView indexPathForCell:cell];
    switch (index) {
        case 0:
        {
            //编辑房源
            [self switchToEditController:self.indexPath];
            break;
        }
        case 1:
        {
            //违规房源仅有删除房源操作
            [self deleteItemAtIndexPath:self.indexPath];
            break;
        }
        default:
            break;
    }
}

- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath {
    [self deleteItemsFromDataSourceAtIndexPath:indexPath];
    [self.contactTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
    [self.contactTableView reloadData];
}

- (void)deleteItemsFromDataSourceAtIndexPath:(NSIndexPath *)indexPath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    Contact *contact = self.dataArray[indexPath.row];
    NSError *error;
    BOOL success = [fileManager removeItemAtURL:[NSURL URLWithString:contact.defaultImagePath] error:&error];
    [fileManager removeItemAtURL:[NSURL URLWithString:contact.nameAudioPath] error:&error];
    [fileManager removeItemAtURL:[NSURL URLWithString:contact.telephoneNumberAudioPath] error:&error];
    [fileManager removeItemAtURL:[NSURL URLWithString:contact.addressAudioPath] error:&error];
    if (success) {
    } else {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    [context deleteObject:self.dataArray[indexPath.row]];
    BOOL isSaveSuccess = [appDelegate.managedObjectContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    } else {
        NSLog(@"Delete successful!");
    }
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
}

- (void)call:(id)sender {
    UIButton *button = (UIButton *)sender;
    int tagNumber = button.tag;
    self.indexPath = [NSIndexPath indexPathForRow:tagNumber inSection:0];
    [self callNumber:self.indexPath];
}

- (void)callNumber:(NSIndexPath *)indexPath {
    Contact *contact = self.dataArray[indexPath.row];
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", contact.telephoneNumber]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}

- (void)switchToEditController:(NSIndexPath *)index {
    BOOL edit = YES;
    Contact *contact = self.dataArray[index.row];
    
    AddViewController *editController = [[AddViewController alloc] init];
    //将contact对象传递给AddViewController
    editController.contact = contact;
    editController.editContact = edit;
    [self.navigationController pushViewController:editController animated:YES];
}

#pragma  mark - playAudio
- (NSURL *)chooseUrl:(int)tag {
    NSURL *url;
    Contact *contact = self.dataArray[tag];
    switch (self.recordTag) {
        case 1:{
            url = [NSURL URLWithString:contact.nameAudioPath];
            break;
        }
        case 2:{
            url = [NSURL URLWithString:contact.telephoneNumberAudioPath];
            break;
        }
        default:{
            url = [NSURL URLWithString:contact.addressAudioPath];
            break;
        }
    }
    return url;
}

#pragma mark - tapGesture
- (void)nameTapped:(UITapGestureRecognizer *)sender {
    int tag = [sender view].tag;
    self.recordTag = 1;
    [self playAudio:tag];
}

- (void)telephoneTapped:(UITapGestureRecognizer *)sender {
    int tag = [sender view].tag;
    self.recordTag = 2;
    [self playAudio:tag];
}

- (void)addressTapped:(UITapGestureRecognizer *)sender {
    int tag = [sender view].tag;
    self.recordTag = 3;
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

- (void)contactTapped:(UITapGestureRecognizer *)sender {
    //获取tag
    int tag = [sender view].tag;
    //获取对应的contact对象
    Contact *contact = self.dataArray[tag];
    ShowViewController *showDetailController = [[ShowViewController alloc] init];
    //将contact对象传递给ShowViewController
    showDetailController.contact = contact;
    [self.navigationController pushViewController:showDetailController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
