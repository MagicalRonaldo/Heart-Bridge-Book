//
//  HBTableViewCell.m
//  NoteBook
//
//  Created by xubing on 14-9-4.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import "HBTableViewCell.h"
#import "UIColor+HB.h"

@interface HBTableViewCell()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *topLine;

@end

@implementation HBTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (BOOL)configureCell:(id)dataModel
{
    return NO;
}

- (BOOL)configureCell:(id)dataModel withIndex:(int)index
{
    self.selectRow = index;
    return NO;
}

- (void)initUI {
}

- (void)showBottonLineWithCellHeight:(CGFloat)cellH
{
    if (self.lineView == nil) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, cellH - 0.5, ScreenWidth - 0, 0.5)];
        self.lineView.backgroundColor = [UIColor GrayLine1Color];
        [self.contentView addSubview:self.lineView];
    } else {
        self.lineView.frame = CGRectMake(0, cellH - 0.5, ScreenWidth, 0.5);
    }
}

- (void)showBottonLineWithCellHeight:(CGFloat)cellH andOffsetX:(CGFloat)offsetX
{
    if (self.lineView == nil) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(offsetX, cellH - 0.5, ScreenWidth - 2 * offsetX, 0.5)];
        self.lineView.backgroundColor = [UIColor GrayLine1Color];
        [self.contentView addSubview:self.lineView];
    } else {
        self.lineView.frame = CGRectMake(offsetX, cellH - 0.5, ScreenWidth - 2 * offsetX, 0.5);
    }
}

- (void)showTopLineWithOffsetX:(CGFloat)offsetX
{
    if (self.topLine == nil) {
        self.topLine = [[UIView alloc] initWithFrame:CGRectMake(offsetX, -0.5, ScreenWidth - offsetX, 0.5)];
        self.topLine.backgroundColor = [UIColor GrayLine1Color];
        [self.contentView addSubview:self.topLine];
    }
    
    self.topLine.frame = CGRectMake(offsetX, 0, ScreenWidth - offsetX, 0.5);
}

- (void)showTopLine
{
    if (self.topLine == nil) {
        self.topLine = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, ScreenWidth, 0.5)];
        self.topLine.backgroundColor = [UIColor GrayLine1Color];
        [self.contentView addSubview:self.topLine];
    }
    self.topLine.hidden = NO;
    self.topLine.frame = CGRectMake(0, 0, ScreenWidth - 0, 0.5);
}

- (void)hideTopLine
{
    self.topLine.hidden = YES;
}

- (UIView *)baseCellBackgroundView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CELL_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    
    return view;
}

@end
