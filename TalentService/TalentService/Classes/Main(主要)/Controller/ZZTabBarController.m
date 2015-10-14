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
#import "ZZHomeViewController.h"
#import "ZZActivityController.h"
#import "ZZTopicForumTVC.h"
#import "ZZMoreVC.h"
#import "ZZLoginUserTool.h"

@interface ZZTabBarController ()<UIAlertViewDelegate>
@property (nonatomic, strong)UIAlertView *alert;
@end
@implementation ZZTabBarController
-(void)viewDidLoad{
    [super  viewDidLoad];
    // 添加所有子控制器
    [self setUpAllChildViewController];
    [self  setUpShadow];
    //注册通知接受token失效
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tokenIsNoActive:) name:ZZTokenIsNoActive object:nil];
}

- (void)setUpShadow{
    self.tabBar.backgroundColor = [UIColor  whiteColor];
    self.tabBar.layer.shadowColor = ZZSeparGrayColor.CGColor;//shadowColor阴影颜色
    self.tabBar.layer.shadowOffset = CGSizeMake(0,-2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.tabBar.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.tabBar.layer.shadowRadius = 2;//阴影半径，默认3
    
    self.tabBar.translucent = NO;
}
- (void)setUpAllChildViewController{

    ZZHomeViewController *home = [[ZZHomeViewController alloc] init];
    
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"home_close_30x30"] selectedImage:[UIImage imageWithOriginalName:@"home_open_30x30"] title:@"首页"];
    
    // 活动
    ZZActivityController *activity = [[ZZActivityController alloc] init];
    
    [self setUpOneChildViewController:activity image:[UIImage imageNamed:@"event_close_30x30"] selectedImage:[UIImage imageWithOriginalName:@"event_open_30x30"] title:@"服务"];

//    // 社区
//    ZZTopicForumTVC *topic = [[ZZTopicForumTVC alloc] init];
//    
//    [self setUpOneChildViewController:topic image:[UIImage imageNamed:@"city_close_30x30"] selectedImage:[UIImage imageWithOriginalName:@"city_open_30x30"] title:@"社区"];

    // 我的
    ZZInfoVC *me = [[ZZInfoVC alloc] init];
    [self setUpOneChildViewController:me image:[UIImage imageNamed:@"mine_close_30x30"] selectedImage:[UIImage imageWithOriginalName:@"mine_open_30x30"] title:@"我的"];
    
    // 更多
    ZZMoreVC *more = [[ZZMoreVC alloc] init];
    [self setUpOneChildViewController:more image:[UIImage imageNamed:@"more_close_30x30"] selectedImage:[UIImage imageWithOriginalName:@"more_open_30x30"] title:@"更多"];
}
#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = image;
   vc.tabBarItem.selectedImage = selectedImage;
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -1)];
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = ZZNatiBarColor;
    [vc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    ZZNaviController *nav = [[ZZNaviController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}
#pragma mark -token失效方法
- (void)tokenIsNoActive:(NSNotification *)noti{
    NSString *tipstr = noti.userInfo[ZZTokenIsNoActiveError];
    if (tipstr == nil) {
        tipstr = @"你的账号信息已失效，请重新登录";
    }
    [ZZLoginTool save:nil];
    if (self.alert.isVisible) {
        return;
    }
    if (self.alert == nil) {
         self.alert = [[UIAlertView  alloc]initWithTitle:@"温馨提示" message:tipstr delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    }else{
        self.alert.message = tipstr;
    }
   
    [self.alert  show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
        [self  swithWindowRootControllerToLogin];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
