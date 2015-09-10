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

#import "ZZUMTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     *  窗口初始化
     */
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
   
    [self  swithWindowRootViewController:ZZRootViewControllerTypeHome];
    
    [self.window makeKeyAndVisible];
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

}
/**
 *  进入首页等界面
 */
-(void)presentMenuViewController{
    ZZTabBarController* tabBarc = [[ZZTabBarController alloc]init];
    [self.window setRootViewController:tabBarc];
}


//切换window的跟视图控制器
- (void)swithWindowRootViewController:(ZZRootViewControllerType )vcType{
    switch (vcType) {
        case ZZRootViewControllerTypeLogin:
        {
            [self  addLoginViewController];
        }
        break;
     case ZZRootViewControllerTypeHome:
        {
            [self   presentMenuViewController];
        }
        break;
    }
}
#pragma mark -内存警告
/** 接受到内存警告，停止加载所有图片，并清除内存缓存 */
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [ZZSdWebImageTool  receiveMemoryWarningClearImageMemory];
}
#pragma mark - 三方回调
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [ZZUMTool  umSocialHandleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
     return  [ZZUMTool  umSocialHandleOpenURL:url];
}
@end
