//
//  UIControl+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/9/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Extension)
@property (nonatomic, assign) NSTimeInterval uxy_acceptEventInterval;

- (void)uxy_handleControlEvent:(UIControlEvents)event withBlock:(void(^)(id sender))block;
- (void)uxy_removeHandlerForEvent:(UIControlEvents)event;
@end
