//
//  Cell.m
//  CollectionViewSample
//
//  Created by xubing on 13-12-23.
//  Copyright (c) 2013年 xubing. All rights reserved.
//

#import "ContactCell.h"

@interface ContactCell ()

//cell配置
@property (nonatomic, strong) UIImageView *selectImage;
@property (nonatomic, strong) UIButton *selectStylebutton;
@property (nonatomic, strong) UIImageView *propertyIcon; //房源图片
@property (nonatomic, strong) UILabel *propertyTitle; //房源标题
@property (nonatomic, strong) UILabel *community; //小区名称
@property (nonatomic, strong) UILabel *houseType; //户型
@property (nonatomic, strong) UILabel *area; //面积
@property (nonatomic, strong) UILabel *price; //售价
@property (nonatomic, strong) NSString *propertyId;//房源Id
@property (nonatomic, strong) UIView *icons; //承载小图标
@property (nonatomic) int propertyTitleLength;

@property (nonatomic)BOOL isSelected;

@end

@implementation ContactCell

@end