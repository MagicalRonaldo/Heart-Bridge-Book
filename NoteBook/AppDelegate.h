//
//  AppDelegate.h
//  NoteBook
//
//  Created by xubing on 13-12-28.
//  Copyright (c) 2013年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) UINavigationController *navController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

//managedObjectModel的初始化赋值函数
- (NSManagedObjectModel *)managedObjectModel;

//managedObjectContext的初始化赋值函数
- (NSManagedObjectContext *)managedObjectContext;

- (NSArray *) fetchObjectsWithEntity:(NSString *)entityName
                           predicate:(NSString *)predicateName
                                sort:(NSString *)sortName
                           ascending:(BOOL)ascending;

@end
