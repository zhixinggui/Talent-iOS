//
//  UUPhotoConst.h
//  UUPhotoActionSheet
//
//  Created by zhizhen on 15/7/30.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kNotificationSendPhotos;
extern NSString * const kNotificationUpdateSelected;
extern NSString * const kNotificationUpdateImageOrigin;
extern NSString * const ImageOrigin;
//创建单例
#ifndef SHARED_SERVICE
#define SHARED_SERVICE(ServiceName) \
+(instancetype)sharedInstance \
{ \
static ServiceName * sharedInstance; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[ServiceName alloc] init]; \
}); \
return sharedInstance; \
}
#endif



//颜色
#define COLOR_WITH_RGB(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

//十进制颜色
#define COLOR_WITH_RGB(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

