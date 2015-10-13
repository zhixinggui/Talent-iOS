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
#import "ZZLoginUserTool.h"

#import "UMessage.h"

#import <TAESDK/TAESDK.h>

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define _IPHONE80_ 80000
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     *  窗口初始化
     */
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
   
    /**开启taesdk的测试模式，可以获取更多的debug信息**/
    [[TaeSDK sharedInstance] setDebugLogOpen:YES];
    
    [UMessage startWithAppkey:@"560131d3e0f55a5dc1001859" launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
    [UMessage setLogEnabled:YES];
    
    if (ZZLoginTool.loginToken.length) {
        [self  swithWindowRootViewController:ZZRootViewControllerTypeHome];
    }else{
        [self  swithWindowRootViewController:ZZRootViewControllerTypeLogin];
    }
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


/**
 *  友盟推送设置
 *
 *  @param application <#application description#>
 *  @param deviceToken <#deviceToken description#>
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    [UMessage registerDeviceToken:deviceToken];
    NSLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
}

-(void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    
    NSString *error_str = [NSString stringWithFormat: @"%@", err];
    NSLog(@"Failed to get token, error:%@", error_str);
    
}


@end
