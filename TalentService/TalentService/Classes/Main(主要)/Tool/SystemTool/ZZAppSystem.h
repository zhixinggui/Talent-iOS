//
//  ZZAppSystem.h
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const BOOL IOS8_OR_LATER;
extern const BOOL IOS7_OR_LATER;
extern const BOOL IOS6_OR_LATER;
extern const BOOL IOS5_OR_LATER;
extern const BOOL IOS4_OR_LATER;
extern const BOOL IOS3_OR_LATER;
extern const BOOL IOS7_OR_EARLIER;
extern const BOOL IOS6_OR_EARLIER;
extern const BOOL IOS5_OR_EARLIER;
extern const BOOL IOS4_OR_EARLIER;
extern const BOOL IOS3_OR_EARLIER;
extern const BOOL IS_SCREEN_4_INCH;
extern const BOOL IS_SCREEN_35_INCH;

@interface ZZAppSystem : NSObject

/**
 *  当前系统名称版本
 *
 *  @return 系统名称＋系统版本
 */
+ (NSString *)OSVersion;

/**
 *  app 当前版本
 *
 *  @return app Version 1.0.0
 */
+ (NSString *)appVersion;

/**
 *  app 内部版本号
 *
 *  @return app  bundle  11
 */
+ (NSString *)appBundle;

/**
 *  app标识
 *
 *  @return 当前app的Bundle Identifier
 */
+ (NSString *)appIdentifier;

/**
 *  设备UDID
 *
 *  @return <#return value description#>
 */
+ (NSString *)appUDID;

/**
 *  通过url打开用应用
 *
 *  @return
 */
+ (NSString *)appSchema;
+ (NSString *)appSchema:(NSString *)name;

/**
 *  当前设备类型
 *
 *  @return e.g. @"iPhone", @"iPod touch"
 */
+ (NSString *)deviceModel;

/**
 *  设备型号 如 iPhone 7,1
 *
 *  @return <#return value description#>
 */
+ (NSString *)appPlatform;

/**
 *  当前设备名称
 *
 *  @return "My iPhone"
 */
+ (NSString *)deviceName;

+ (BOOL)isJailBroken		NS_AVAILABLE_IOS(4_0);
+ (NSString *)jailBreaker	NS_AVAILABLE_IOS(4_0);

/*
+ (BOOL)isDevicePhone;
+ (BOOL)isDevicePad;

+ (BOOL)requiresPhoneOS;
*/
/**
 *  跳转到AppStore
 *  params  appID 对应的app的id  ，默认为萌宝派的id
 */
+(void)jumpToAppStoreWithAppID:(long)appID;
@end
