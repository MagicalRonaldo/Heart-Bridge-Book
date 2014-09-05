//
//  HBTableViewCell.h
//  NoteBook
//
//  Created by xubing on 14-9-4.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_TITLE_FONT 15
#define CELL_HEIGHT 45
#define CELL_OFFSET_TITLE 15
#define IMG_OFFSET_TITLE 17
#define CELL_OFFSET_PHONEICON 287

#define CELL_MESSAGELIST_OFFSETX 15

@interface HBTableViewCell : UITableViewCell

@property int selectRow; //当前此cell所在row
@property int indexTag; //编号
@property CGFloat cellHeight;

- (void)initUI; // init UI for cell reuse
- (BOOL)configureCell:(id)dataModel; //传递cell数据
- (BOOL)configureCell:(id)dataModel withIndex:(int)index; //传递cell数据_with Index

- (void)showBottonLineWithCellHeight:(CGFloat)cellH;
- (void)showTopLine;
- (void)hideTopLine;
- (void)showTopLineWithOffsetX:(CGFloat)offsetX;
- (void)showBottonLineWithCellHeight:(CGFloat)cellH andOffsetX:(CGFloat)offsetX;

- (UIView *)baseCellBackgroundView;
@end
