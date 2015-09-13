//
//  UIBarButtonItem+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/7/30.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action ;

+ (NSArray *)backItemWithTarget:(id)target action:(SEL)action ;
@end
