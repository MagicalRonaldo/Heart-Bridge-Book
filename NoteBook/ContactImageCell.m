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
        self.defaultContactImage = [[UIImageView alloc] initWithFrame:(CGRectMake(20, 10, 150, 150))];
        self.defaultContactImage.layer.cornerRadius = 15.0f;
        self.defaultContactImage.layer.masksToBounds = YES;
        self.defaultContactImage.image = [UIImage imageNamed:@"08.png"];
        [self.contentView addSubview:self.defaultContactImage];
        
        self.selectDefaultContactImage = [UIButton buttonTextColor:[UIColor brownColor] cordius:2.0 boderWidth:1.0];
        self.selectDefaultContactImage.frame = CGRectMake(190, 30, ScreenWidth - 210, 50);
        [self.selectDefaultContactImage setTitle:@"设 置 头 像" forState:(UIControlStateNormal)];
        self.selectDefaultContactImage.titleLabel.font = [UIFont H2Font];
        [self.contentView addSubview:self.selectDefaultContactImage];
        
        self.contactAlbum = [UIButton buttonTextColor:[UIColor brownColor] cordius:2.0 boderWidth:1.0];
        self.contactAlbum.frame = CGRectMake(190, 100, ScreenWidth - 210, 50);
        [self.contactAlbum setTitle:@"编 辑 相 册" forState:(UIControlStateNormal)];
        self.contactAlbum.titleLabel.font = [UIFont H2Font];
        [self.contentView addSubview:self.contactAlbum];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
