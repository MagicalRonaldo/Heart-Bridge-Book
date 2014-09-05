//
//  FirstViewController.h
//  NoteBook
//
//  Created by xubing on 14-1-2.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AddViewController.h"

@interface HomeViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) AVAudioPlayer *avPlay;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)option:(id)sender;
- (IBAction)call:(id)sender;

@end
