//
//  Cell.h
//  CollectionViewSample
//
//  Created by xubing on 13-12-23.
//  Copyright (c) 2013年 xubing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell :UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *tele;
@property (strong, nonatomic) IBOutlet UIButton *btnOption;
@property (strong, nonatomic) IBOutlet UIButton *btnPhone;

@end
