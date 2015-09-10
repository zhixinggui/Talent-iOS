//
//  ZZResignParam.h
//  TalentService
//
//  Created by zhizhen on 15/9/9.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZResignParam : NSObject
/**手机号*/
@property (nonatomic, copy)NSString *loginAccount;
/**密码*/
@property (nonatomic, copy)NSString *loginPassword;
/**用户昵称*/
@property (nonatomic, copy)NSString *userNike;
/**省*/
@property (nonatomic, strong) NSNumber  *province;
/**市*/
@property (nonatomic, strong) NSNumber  *city;
/**区*/
@property (nonatomic, strong) NSNumber  *district;
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
/**设备版本*/
@property (nonatomic, copy)NSString *applicationVersion;
/**设备型号*/
@property (nonatomic, copy)NSString *model;
/**int	"登录设备：//0 IOS  //1 安卓"*/
@property (nonatomic, strong) NSNumber  *device;
//device	int	"登录设备：
//1 IOS
//2 安卓"
//deviceVersion	String	设备版本
//model	String	设备型号
//imei	String	IMEI
//applicationVersion	String	应用系统版本
@end
