//
//  TextAndRecordCell.m
//  NoteBook
//
//  Created by xubing on 14-9-17.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "TextAndRecordCell.h"
#import "UILabel+HB.h"
#import "UIButton+HB.h"

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
        
        self.infoTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + 50 + 20, 10, 200, 40)];
        self.infoTextField.borderStyle = UITextBorderStyleRoundedRect;
        
        self.recordLabel = [UILabel labelFont:[UIFont H2Font] textColor:[UIColor BlackColor]];
        self.recordLabel.frame = CGRectMake(15, 80, 0, 0);
        [self.contentView addSubview:self.recordLabel];
        
        self.recordButton = [UIButton buttonNomalColor:[UIColor BlueColor] highLightColor:[UIColor colorWithHex:0x2069a6 alpha:1.0] coRadius:2.0];
        [self.contentView addSubview:self.recordButton];
        
        self.playButton = [UIButton buttonNomalColor:[UIColor BlueColor] highLightColor:[UIColor colorWithHex:0x2069a6 alpha:1.0] coRadius:2.0];
        [self.contentView addSubview:self.playButton];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
