//
//  Cell.m
//  CollectionViewSample
//
//  Created by xubing on 13-12-23.
//  Copyright (c) 2013年 xubing. All rights reserved.
//

#import "ContactCell.h"
#import "UIColor+HB.h"
#import "UIFont+HB.h"
#import "UIView+HB.h"

@implementation ContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containingTableView:(UITableView *)containingTableView leftUtilityButtons:(NSArray *)leftUtilityButtons rightUtilityButtons:(NSArray *)rightUtilityButtons
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier containingTableView:containingTableView leftUtilityButtons:leftUtilityButtons rightUtilityButtons:rightUtilityButtons];
    
    if (self) {
        [self initCell];
    }
    return self;
}

#pragma mark UI相关
- (void)initCell
{
    self.contentView.backgroundColor = [UIColor redColor];
    
    //图像
    self.contactImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.contactImage.contentMode = UIViewContentModeCenter;
    self.contactImage.backgroundColor = [UIColor clearColor];
    self.contactImage.layer.cornerRadius = 2.0f;
    self.contactImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.contactImage];
    
    //名字
    self.contactName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contactName.backgroundColor = [UIColor clearColor];
    self.contactName.font = [UIFont H3Font_B];
    [self.contactName setTextColor:[UIColor BlackColor]];
    [self.contentView addSubview:self.contactName];
    
    //电话号码
    self.contactTele = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contactTele.backgroundColor = [UIColor clearColor];
    self.contactTele.font = [UIFont H4Font];
    self.contactTele.textColor = [UIColor LightGrayColor];
    [self.contentView addSubview:self.contactTele];
    
    //打电话
    self.call = [UIButton buttonWithType:UIButtonTypeCustom];
    self.call.backgroundColor = [UIColor redColor];
    [self.call setImage:[UIImage imageNamed:@"anjuke_icon_back"] forState:UIControlStateNormal];
    self.contentView.backgroundColor = [UIColor WhiteColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contactImage.frame = CGRectMake(5, 10, 130, 130);
    self.contactImage.layer.cornerRadius = 15.0;
    self.contactImage.layer.masksToBounds = YES;
    
    self.contactName.frame = CGRectMake(120, 20, 180, 40);
    self.contactTele.frame =CGRectMake(120, 70, 180, 40);
    self.call.frame = CGRectMake(120, 120, 180, 20);
}

@end
