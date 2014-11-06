//
//  TextAndRecordCell.h
//  NoteBook
//
//  Created by xubing on 14-9-17.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBTableViewCell.h"

@class TextAndRecordCell;

@protocol InfoCellDelegate <NSObject>

@optional
- (void)recordButtonTapped: (TextAndRecordCell *)cell;
- (void)playButtonTapped:(TextAndRecordCell *)cell;
@end

@interface TextAndRecordCell : HBTableViewCell

@property (nonatomic, strong) UITextField *infoTextField;
@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) id<InfoCellDelegate> delegate;

- (void)configCellWithText:(NSString *)text;

@end
