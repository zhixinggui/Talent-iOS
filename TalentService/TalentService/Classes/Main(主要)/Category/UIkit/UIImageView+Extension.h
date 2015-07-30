//
//  UIImageView+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)
/**
 *  网络加载图片，并设置默认图片
 *
 *  @param url       网络路径 ，NSString
 *  @param imageName 默认图片名字
 */
-(void)setImageWithURL:(NSString*)url placeholderImageName:(NSString*)imageName ;
@end
