//
//  ContactImageCellTableViewCell.m
//  NoteBook
//
//  Created by xubing on 14-9-17.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "ContactImageCell.h"

@implementation ContactImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.defaultContactImage = [[UIImageView alloc] initWithFrame:(CGRectMake(20, 2, 150, 150))];
        self.defaultContactImage.layer.cornerRadius = 15.0f;
        self.defaultContactImage.layer.masksToBounds = YES;
//        self.defaultContactImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.contact.defaultImagePath]]];
        self.defaultContactImage.image = [UIImage imageNamed:@"08.png"];
        [self.contentView addSubview:self.defaultContactImage];
        
        UIButton *buttonSetPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buttonSetPhoto.frame = CGRectMake(190, 20, ScreenWidth - 210, 50);
        [buttonSetPhoto setTitle:@"设 置 头 像" forState:(UIControlStateNormal)];
//        [buttonSetPhoto addTarget:self action:@selector(editDefaultImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:buttonSetPhoto];
        
        UIButton *buttonAddPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buttonAddPhoto.frame = CGRectMake(190, 90, ScreenWidth - 210, 50);
        [buttonAddPhoto setTitle:@"编 辑 相 册" forState:(UIControlStateNormal)];
//        [buttonAddPhoto addTarget:self action:@selector(editAlbum:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:buttonAddPhoto];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
