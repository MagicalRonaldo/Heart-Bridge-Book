//
//  BaseModel.h
//  NoteBook
//
//  Created by xubing on 14-9-4.
//  Copyright (c) 2014年 xubing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject <NSCoding>{
    
}

-(id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;

- (NSString *)cleanString:(NSString *)str;    //清除\n和\r的字符串

@end
