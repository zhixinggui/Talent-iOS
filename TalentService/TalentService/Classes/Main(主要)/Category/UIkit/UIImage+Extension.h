//
//  UIImage+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/7/29.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *返回中心拉伸的图片
 */
+(UIImage *)stretchedImageWithName:(NSString *)name;

/**
 *  对照片进行处理之前，先将照片旋转到正确的方向，并且返回的imageOrientaion为0。
 *
 */
- (UIImage *)fixOrientation:(UIImage *)aImage;
@end
