//
//  Contact.h
//  NoteBook
//
//  Created by xubing on 14-2-17.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *addressAudioPath;
@property (nonatomic, retain) id album;
@property (nonatomic, retain) NSDate *creatDate;
@property (nonatomic, retain) NSString *defaultImagePath;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *nameAudioPath;
@property (nonatomic, retain) NSString *telephoneNumber;
@property (nonatomic, retain) NSString *telephoneNumberAudioPath;

@end
