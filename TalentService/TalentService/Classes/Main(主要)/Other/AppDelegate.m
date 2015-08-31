//
//  AppDelegate.m
//  TalentService
//
//  Created by zhizhen on 15/7/24.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "AppDelegate.h"
#import "ZZLoginVC.h"
#import "ZZNaviController.h"
#import "ZZTabBarController.h"
#import "ZZSdWebImageTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     *  窗口初始化
     */
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    /**
     *  登录
     */
    //[self addLoginViewController];
    /**
     *  进入首页界面
     */
    [self presentMenuViewController];
    
    return YES;
}
/**
 *  登录路口
 */
-(void)addLoginViewController{
    ZZLoginVC *loginVc = [[ZZLoginVC alloc]initWithNibName:@"ZZLoginVC" bundle:nil];
    ZZNaviController *loginNavi = [[ZZNaviController alloc]initWithRootViewController:loginVc];
    loginNavi.navigationBarHidden = YES;
    self.window.rootViewController = loginNavi;

//    ZZLoginVC *loginVc = [[ZZLoginVC alloc]initWithNibName:@"ZZLoginVC" bundle:nil];
//    ZZNaviController *loginNavi = [[ZZNaviController alloc]initWithRootViewController:loginVc];
//    loginNavi.navigationBarHidden = YES;



}
/**
 *  进入首页等界面
 */
-(void)presentMenuViewController{
    ZZTabBarController* tabBarc = [[ZZTabBarController alloc]init];
    [self.window setRootViewController:tabBarc];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
   
}

/**
 *  接受到内存警告，停止加载所有图片，并清除内存缓存
 */
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [ZZSdWebImageTool  receiveMemoryWarningClearImageMemory];
}

@end
