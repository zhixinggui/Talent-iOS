//
//  ZZRefreshHeader.m
//  TalentService
//
//  Created by zhizhen on 15/10/16.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZRefreshHeader.h"

@implementation ZZRefreshHeader
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i<7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim_%d",i]];
        [idleImages addObject:image];
    }
    
  
    
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
    [self setImages:idleImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateRefreshing];
    
 
}

@end
