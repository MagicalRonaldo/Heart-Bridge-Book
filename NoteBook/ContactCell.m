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

@interface ContactCell ()

@end

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
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    //图像
    self.contactImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    self.contactImage.contentMode = UIViewContentModeCenter;
    self.contactImage.backgroundColor = [UIColor clearColor];
    self.contactImage.layer.cornerRadius = 2.0f;
    self.contactImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.contactImage];
    
    //名字
    self.contactName = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 180, 40)];
    self.contactName.backgroundColor = [UIColor clearColor];
    self.contactName.font = [UIFont H3Font_B];
    [self.contactName setTextColor:[UIColor BlackColor]];
    [self.contentView addSubview:self.contactName];
    
    //电话号码
    self.contactTele = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, 200, 40)];
    self.contactTele.backgroundColor = [UIColor clearColor];
    self.contactTele.font = [UIFont H4Font];
    self.contactTele.textColor = [UIColor LightGrayColor];
    [self.contentView addSubview:self.contactTele];
    
    //电话号码
    self.call = [UIButton buttonWithType:UIButtonTypeCustom];
    self.call.backgroundColor = [UIColor clearColor];
    self.call.frame = CGRectMake(100, 100, 40, 40);
    [self.call setImage:[UIImage imageNamed:@"anjuke_icon_back"] forState:UIControlStateNormal];
    
    self.contentView.backgroundColor = [UIColor WhiteColor];
}

@end
