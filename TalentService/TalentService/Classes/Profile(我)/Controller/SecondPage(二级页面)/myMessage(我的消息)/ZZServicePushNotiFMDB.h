//
//  ZZServicePushNotiFMDB.h
//  TalentService
//
//  Created by charles on 15/10/29.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZServiceNotiMessage.h"
@interface ZZServicePushNotiFMDB : NSObject
/**
 *存入数据
 */
+ (void)uploadWithNotifation:(ZZServiceNotiMessage *)serviceNotiMessage;
/**
 *读取数据
 */
+(NSArray*)notificationWithType:(NSInteger)type;
@end
