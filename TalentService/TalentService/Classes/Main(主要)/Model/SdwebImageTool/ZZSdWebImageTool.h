//
//  ZZSdWebImageTool.h
//  TalentService
//
//  Created by zhizhen on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZSdWebImageTool : NSObject
/**
 *  收到内存警告清除缓存
 */
+ (void)receiveMemoryWarningClearImageMemory;

/**
 *  得到图片缓存大小
 *
 *  @return <#return value description#>
 */
+ (NSString *)sdImageCacheSize;

/**
 *  点击清理图片缓存
 */
+ (void)clickClearImageCache;
@end
