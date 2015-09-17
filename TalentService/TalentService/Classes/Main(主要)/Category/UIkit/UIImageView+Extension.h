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
 *  SDWebImageOptions
 *  SDWebImageRetryFailed | SDWebImageLowPriority
 *  @param url       网络路径 ，NSString
 *  @param imageName 默认图片名字
 */
-(void)setImageWithURL:(NSString*)url ;

/**
 *  网络加载头像，并设置默认图片
 *  与上一个方法区别是SDWebImageOptions不同
 *  SDWebImageRetryFailed | SDWebImageLowPriority |SDWebImageRefreshCached
 *  @param url       网络路径 ，NSString
 *  @param imageName 默认图片名字
 */
-(void)setHeadImageWithURL:(NSString*)url;
@end
