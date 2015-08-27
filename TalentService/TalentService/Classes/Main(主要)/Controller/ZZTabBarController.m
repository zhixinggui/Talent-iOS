//
//  ZZTabBarController.m
//  TalentService
//
//  Created by zhizhen on 15/7/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZTabBarController.h"
#import "ZZNaviController.h"
#import "ZZInfoVC.h"
@implementation ZZTabBarController
-(void)viewDidLoad{
    [super  viewDidLoad];
    // 添加所有子控制器
    [self setUpAllChildViewController];
}

- (void)setUpAllChildViewController{
    // 首页
    UIViewController *home = [[UIViewController alloc] init];
    home.view.backgroundColor = [UIColor redColor];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"home_close_30x30"] selectedImage:[UIImage imageWithOriginalName:@"home_open_30x30"] title:@"首页"];
    
    // 活动
    UIViewController *activity = [[UIViewController alloc] init];
    activity.view.backgroundColor = [UIColor  greenColor];
    [self setUpOneChildViewController:activity image:[UIImage imageNamed:@"event_close_30x30"] selectedImage:[UIImage imageWithOriginalName:@"event_open_30x30"] title:@"活动"];
    
    
    // 我的
    ZZInfoVC *me = [[ZZInfoVC alloc] init];
    [self setUpOneChildViewController:me image:[UIImage imageNamed:@"mine_close_30x30"] selectedImage:[UIImage imageWithOriginalName:@"mine_open_30x30"] title:@"我的"];
    
    // 更多
    UIViewController *more = [[UIViewController alloc] init];
     more.view.backgroundColor = [UIColor  yellowColor];
    [self setUpOneChildViewController:more image:[UIImage imageNamed:@"more_close_30x30"] selectedImage:[UIImage imageWithOriginalName:@"more_open_30x30"] title:@"更多"];
}
#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;
    
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = ZZGreenColor;
    [vc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    ZZNaviController *nav = [[ZZNaviController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}
@end
