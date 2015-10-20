//
//  UIBarButtonItem+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/30.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#define separWidth  -10.0

@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}



+ (NSArray *)backItemWithTarget:(id)target action:(SEL)action {
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *back = [UIBarButtonItem  itemWithTarget:target action:action image:@"return_30x30" highImage:nil];
    
    negativeSeperator.width = -16;//此处修改到边界的距离，请自行测试
   return  @[negativeSeperator,back];
}

+ (NSArray *)leftItemWithTarget:(id)target action:(SEL)action image:(NSString *)imageName{
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *left = [UIBarButtonItem  itemWithTarget:target action:action image:imageName highImage:nil];
    
    negativeSeperator.width = separWidth;//此处修改到边界的距离，请自行测试
    return  @[negativeSeperator,left];
}

+ (NSArray *)rightItemWithTarget:(id)target action:(SEL)action image:(NSString *)imageName{
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem* right = [UIBarButtonItem  itemWithTarget:target action:action image:imageName highImage:nil];
    
    negativeSeperator.width = separWidth;//此处修改到边界的距离，请自行测试
    return  @[negativeSeperator,right];
}
@end
