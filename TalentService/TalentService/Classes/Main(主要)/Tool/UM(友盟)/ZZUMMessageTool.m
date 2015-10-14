//
//  ZZUMMessageTool.m
//  TalentService
//
//  Created by zhizhen on 15/10/14.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZUMMessageTool.h"
#import "UMessage.h"
#import "ZZLoginUserTool.h"
/**别名类型*/
NSString * const ZZAliasType  = @"service";//连接服务器中
//友盟推送
NSString * const UMMessageAppKey = @"560131d3e0f55a5dc1001859";
#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define _IPHONE80_ 80000

@implementation ZZUMMessageTool
+(void)umMessageRegisterRemoteNotificationWithOptions:(NSDictionary *)launchOptions {
    [UMessage startWithAppkey:UMMessageAppKey launchOptions:launchOptions];
    
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

}

+ (void)umMessageRegisterDeviceToken:(NSData *)deviceToken{
    [UMessage registerDeviceToken:deviceToken];
    NSLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
}

+ (void)umMessageDidReceiveRemoteNotification:(NSDictionary *)userInfo{
     [UMessage didReceiveRemoteNotification:userInfo];
}

+ (void)umMessageAddAlias{
    ZZLoginUser* loginUser =  ZZLoginTool.loginUser;
    if (loginUser == nil) {
        return;
    }
    //用户id绑定alias
    [UMessage addAlias:[NSString stringWithFormat:@"%ld_%@",loginUser.userId,[ZZAppSystem  appUDID]] type:ZZAliasType response:^(id responseObject, NSError *error) {
        NSString *str = [NSString stringWithFormat:@"%ld_%@",loginUser.userId,[ZZAppSystem  appUDID]];
        ZZLog(@"alias: %@",str);
    }];
}

+ (void)umMessageRemoveAlias{
    ZZLoginUser* loginUser =  ZZLoginTool.loginUser;
    if (loginUser == nil) {
        return;
    }
    [UMessage removeAlias:[NSString stringWithFormat:@"%ld_%@",loginUser.userId,[ZZAppSystem  appUDID]] type:ZZAliasType response:^(id responseObject, NSError *error) {
        
    }];
}
@end
