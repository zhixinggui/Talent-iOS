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

-(void)setImageWithURL:(NSString*)url{
    [self  sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage  imageNamed:@"default100x100.png"]options:SDWebImageRetryFailed | SDWebImageLowPriority ];
}

-(void)setHeadImageWithURL:(NSString*)url{
    
   
     [self  sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage  imageNamed:@"default_icon_60x60.png" ] options:SDWebImageRetryFailed | SDWebImageLowPriority |SDWebImageRefreshCached];
}


#pragma mark
-(void)addTarget:(id)target action:(SEL)action{
  
    for (UIGestureRecognizer *tap in self.gestureRecognizers) {
        if ([tap isKindOfClass:UITapGestureRecognizer.class]) {
            [self  removeGestureRecognizer:tap];
        }
    }
    UITapGestureRecognizer *tap = [[ UITapGestureRecognizer  alloc]initWithTarget:target action:action];
   
    [self  addGestureRecognizer:tap];
}
@end
