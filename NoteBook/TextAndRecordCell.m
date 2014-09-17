//
//  TextAndRecordCell.m
//  NoteBook
//
//  Created by xubing on 14-9-17.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "TextAndRecordCell.h"
#import "UILabel+HB.h"

@interface TextAndRecordCell ()

@property (nonatomic, strong) UILabel *recordLabel;

@end

@implementation TextAndRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.infoLabel = [UILabel labelFont:[UIFont H2Font] textColor:[UIColor BlackColor]];
        self.infoLabel.frame = CGRectMake(15, 20, 0, 0);
        [self.contentView addSubview:self.infoLabel];
        
        self.recordLabel = [UILabel labelFont:[UIFont H2Font] textColor:[UIColor BlackColor]];
        self.recordLabel.frame = CGRectMake(15, 80, 0, 0);
        [self.contentView addSubview:self.recordLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
