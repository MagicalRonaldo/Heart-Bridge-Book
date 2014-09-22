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
        self.infoLabel.frame = CGRectMake(15, 20, 50, 40);
        [self.contentView addSubview:self.infoLabel];
        
        self.infoTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 15, 220, 40)];
        self.infoTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self.contentView addSubview:self.infoTextField];
        
        self.recordLabel = [UILabel labelFont:[UIFont H2Font] textColor:[UIColor BlackColor]];
        self.recordLabel.frame = CGRectMake(15, 80, 50, 40);
        self.recordLabel.text = @"录音:";
        [self.recordLabel sizeToFit];
        [self.contentView addSubview:self.recordLabel];
        
        self.recordButton = [UIButton buttonNomalColor:[UIColor brownColor] highLightColor:[UIColor colorWithHex:0x2069a6 alpha:1.0] coRadius:2.0];
        self.recordButton.frame = CGRectMake(80, 70, 100, 40);
        [self.recordButton setTitle:@"录音" forState:UIControlStateNormal];
        self.recordButton.titleLabel.font = [UIFont H2Font];
        
        self.recordButton.tintColor = [UIColor whiteColor];
        [self.contentView addSubview:self.recordButton];
        
        self.playButton = [UIButton buttonNomalColor:[UIColor brownColor] highLightColor:[UIColor colorWithHex:0x2069a6 alpha:1.0] coRadius:2.0];
        self.playButton.frame = CGRectMake(200, 70, 100, 40);
        [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
        self.playButton.titleLabel.font = [UIFont H2Font];
        [self.contentView addSubview:self.playButton];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
