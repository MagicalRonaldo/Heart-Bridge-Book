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
        self.defaultContactImage = [UIImageView imageViewCordius:15.0];
        self.defaultContactImage.frame = (CGRectMake(20, 10, 150, 150));
        [self.contentView addSubview:self.defaultContactImage];
        
        self.selectDefaultContactImage = [UIButton buttonTextColor:[UIColor brownColor] cordius:60.0 boderWidth:1.0];
        self.selectDefaultContactImage.frame = CGRectMake(190, 25, ScreenWidth - 200, ScreenWidth - 200);
        self.selectDefaultContactImage.titleLabel.font = [UIFont H2Font];
        [self.selectDefaultContactImage setBackgroundImage:[[UIImage imageNamed:@"setIma"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
        [self.contentView addSubview:self.selectDefaultContactImage];
        
        UILabel *buttonTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 63, 30, 30)];
        buttonTitle.backgroundColor = [UIColor clearColor];
        buttonTitle.text = @"设置";
        buttonTitle.textColor = [UIColor brownColor];
        [buttonTitle sizeToFit];
        [self.selectDefaultContactImage addSubview:buttonTitle];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
