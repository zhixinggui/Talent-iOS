//
//  ZZImageContent.h
//  TalentService
//
//  Created by zhizhen on 15/9/22.
//  Copyright © 2015年 zhizhen. All rights reserved.
//  图文混排的图片文字

#import <Foundation/Foundation.h>

@interface ZZImageContent : NSObject

@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *imgPath;
@property (nonatomic, copy)NSString *imgBigPath;
@property (nonatomic) CGFloat imgHeight;
@property (nonatomic) CGFloat imgWidth;
//content = aaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
//imgHeight = 250,
//imgPath = http://fuck.image.alimmdn.com/2015-9-17/image_4d3d845b49684c82af3f56198b635763,
//imgWidth
@end
