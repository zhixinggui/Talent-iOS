//
//  UIImageView+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"
//static const char ZZImageViewAction = '\0';
//static const char ZZImageViewTarget = '\0';
@implementation UIImageView (Extension)
//- (SEL)action
//{
//    return NSSelectorFromString(objc_getAssociatedObject(self, &ZZImageViewAction));
//}
//
//- (void)setAction:(SEL)action
//{
//    
//    objc_setAssociatedObject(self, &ZZImageViewAction, NSStringFromSelector(action), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//- (id)target
//{
//    return objc_getAssociatedObject(self, &ZZImageViewTarget) ;
//}
//
//- (void)setTarget:(id)target
//{
//    
//    objc_setAssociatedObject(self, &ZZImageViewTarget,target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

-(void)setPictureImageWithURL:(NSString*)url{
        [self  sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage  imageNamed:@"default100x100.png"]options:SDWebImageRetryFailed | SDWebImageLowPriority ];
}

-(void)setHeadImageWithURL:(NSString*)url{
    
   
     [self  sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage  imageNamed:@"default_icon_60x60.png" ] options:SDWebImageRetryFailed | SDWebImageLowPriority |SDWebImageRefreshCached];
}


#pragma mark
-(void)addTarget:(id)target action:(SEL)action{
//    [self  setTarget:target];
//    [self  setAction:action];
  
    for (UIGestureRecognizer *tap in self.gestureRecognizers) {
        if ([tap isKindOfClass:UITapGestureRecognizer.class]) {
            [self  removeGestureRecognizer:tap];
        }
    }
    UITapGestureRecognizer *tap = [[ UITapGestureRecognizer  alloc]initWithTarget:target action:action];
   
    [self  addGestureRecognizer:tap];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    ZZLog(@"%d,,%@",self.userInteractionEnabled ,[self  target]);
//    if(self.userInteractionEnabled && [self target] && [[self target  ]respondsToSelector:[self  action]]){
//        [[self  target] performSelector:[self action] withObject:self];
//    }
//}
@end
