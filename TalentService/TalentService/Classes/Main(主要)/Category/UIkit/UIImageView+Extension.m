//
//  UIImageView+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (Extension)

-(void)setImageWithURL:(NSString*)url placeholderImageName:(NSString*)imageName{
    [self  sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage  imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:imageName ofType:nil]]options:SDWebImageRetryFailed | SDWebImageLowPriority ];
}

-(void)setHeadImageWithURL:(NSString*)url{
     [self  sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage  imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"" ofType:nil]]options:SDWebImageRetryFailed | SDWebImageLowPriority |SDWebImageRefreshCached];
}
@end
