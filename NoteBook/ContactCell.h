//
//  Cell.h
//  CollectionViewSample
//
//  Created by xubing on 13-12-23.
//  Copyright (c) 2013年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ContactCell:SWTableViewCell

@property (nonatomic, strong) UIImageView *contactImage;//图像
@property (nonatomic, strong) UILabel *contactName; //名字
@property (nonatomic, strong) UILabel *contactTele; //电话号码
@property (nonatomic, strong) UIButton *call; //拨打电话

@end
