//
//  ContactImageCellTableViewCell.h
//  NoteBook
//
//  Created by xubing on 14-9-17.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBTableViewCell.h"

@interface ContactImageCell: HBTableViewCell

@property (nonatomic, strong) UIButton *selectDefaultContactImage;
@property (nonatomic, strong) UIButton *contactAlbum;
@property (nonatomic, strong) UIImageView *defaultContactImage;
@property (nonatomic) BOOL isEditContact;

@end
