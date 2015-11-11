//
//  UIBarButtonItem+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/7/30.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/***/
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

/**返回按钮  有偏移量的*/
+ (NSArray *)backItemWithTarget:(id)target action:(SEL)action ;
/**左侧按钮 图片 有偏移量*/
+ (NSArray *)leftItemWithTarget:(id)target action:(SEL)action image:(NSString *)imageName;

/**右侧按钮 图片 有偏移量*/
+ (NSArray *)rightItemWithTarget:(id)target action:(SEL)action image:(NSString *)imageName;


/***/
+ (UIBarButtonItem *)seperatorItem;
@end
