//
//  ZZUMMessageTool.h
//  TalentService
//
//  Created by zhizhen on 15/10/14.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZUMMessageTool : NSObject

/**注册通知*/
+ (void)umMessageRegisterRemoteNotificationWithOptions:(NSDictionary *)launchOptions ;

/**注册设备编号*/
+ (void)umMessageRegisterDeviceToken:(NSData *)deviceToken;

/**接收到通知*/
+ (void)umMessageDidReceiveRemoteNotification:(NSDictionary *)userInfo;

/**绑定别名 , 一定要在保存好登陆用户后调用*/
+ (void)umMessageAddAlias;

/**移除别名 , 一定要在保存好登陆用户后调用*/
+ (void)umMessageRemoveAlias;
@end
