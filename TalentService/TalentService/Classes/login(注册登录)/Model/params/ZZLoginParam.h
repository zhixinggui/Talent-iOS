//
//  ZZLoginParam.h
//  TalentService
//
//  Created by zhizhen on 15/9/9.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZLoginParam : NSObject
/**手机号登录时手机号*/
@property (nonatomic, copy)NSString *loginAccount;
/**手机号登录时密码*/
@property (nonatomic, copy)NSString *loginPassword;
/**三方登陆时usid*/
@property (nonatomic, copy)NSString *openId;
/**三方登陆时昵称*/
@property (nonatomic, copy)NSString *userNike;

/**登录类型：
 0 本平台登陆
 1 QQ登陆
 2 微信登陆
 3 微博登陆*/
@property (nonatomic, strong) NSNumber *thirdType;
/**设备版本*/
@property (nonatomic, copy)NSString *deviceVersion;
/**IMEI - udid*/
@property (nonatomic, copy)NSString *imei;
/**应用版本*/
@property (nonatomic, copy)NSString *applicationVersion;
/**设备型号*/
@property (nonatomic, copy)NSString *model;
/**int	"登录设备：//1 IOS  //2 安卓"*/
@property (nonatomic, strong) NSNumber  *device;
@end
