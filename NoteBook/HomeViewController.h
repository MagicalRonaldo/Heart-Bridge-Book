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
#import "HandleContactViewController.h"
#import "ContactCell.h"

@interface HomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,NSFetchedResultsControllerDelegate,SWTableViewCellDelegate>

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) AVAudioPlayer *avPlay;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void)call:(id)sender;

@end
