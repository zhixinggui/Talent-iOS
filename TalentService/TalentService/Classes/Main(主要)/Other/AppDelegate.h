//
//  AppDelegate.h
//  TalentService
//
//  Created by zhizhen on 15/7/24.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ZZRootViewControllerTypeLogin, //登陆
    ZZRootViewControllerTypeHome //首页
}ZZRootViewControllerType;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

//切换window的跟视图控制器
- (void)swithWindowRootViewController:(ZZRootViewControllerType )vcType;
@end

