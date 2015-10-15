//
//  ZZSdWebImageTool.m
//  TalentService
//
//  Created by zhizhen on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZSdWebImageTool.h"
#import "SDWebImageManager.h"
@implementation ZZSdWebImageTool
+ (void)receiveMemoryWarningClearImageMemory{
    SDWebImageManager*  webImageMan = [SDWebImageManager  sharedManager];
    [webImageMan   cancelAll];
    [webImageMan.imageCache  clearMemory];
}

+ (NSString *)sdImageCacheSize{
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    return  tmpSize >= 1024 ? [NSString stringWithFormat:@"(%.2fM)",tmpSize/1024/1024] : [NSString stringWithFormat:@"(%.2fK)",tmpSize/1024];
}

+ (void)clickClearImageCache{
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
    //在iOS7中使用上面两个方法缓存总清除不干净，即使断网下还是会有数据。在iOS7中缓存机制做了修改，使用上面两个方法尽清除了SDWebImage的缓存
    //清除系统的缓存
    [[NSURLCache  sharedURLCache] removeAllCachedResponses];
}

+ (void)clickClearImageCacheWithBlock:(void (^)(void))block{

       [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
           block();
       }];
}
@end
