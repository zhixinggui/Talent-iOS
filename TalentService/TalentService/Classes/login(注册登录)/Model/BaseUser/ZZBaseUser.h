//
//  ZZBaseUser.h
//  TalentService
//
//  Created by 张亮亮 on 15/9/13.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZBaseUser : NSObject
/** 用户ID*/
@property (nonatomic, assign)NSUInteger userId;
/** 是否推荐*/
@property (nonatomic, assign)BOOL recommoned;
/**用户昵称*/
@property (nonatomic, copy)NSString *userNike;
/** 性别*/
@property (nonatomic, assign)NSInteger userSex;
/**背景图片*/
@property (nonatomic, copy)NSString *backgroundImg;

/** 用户大头像地址*/
@property (nonatomic, copy)NSString *userBigImg;
/** 用户大头像高度*/
@property (nonatomic) CGFloat userBigHeight;
/** 用户大头像宽度*/
@property (nonatomic) CGFloat userBigWidth;

/** 用户小头像地址*/
@property (nonatomic, copy)NSString *userSmallImg;
/** 用户小头像高度*/
@property (nonatomic) CGFloat userSmallHeight;
/** 用户小头像高度*/
@property (nonatomic) CGFloat userSmallWidth;

/** 登陆账号类型*/
@property (nonatomic) NSInteger loginAccountType;
/** 登陆时间*/
@property (nonatomic, copy)NSString *loginTime;
/** 登陆账号*/
@property (nonatomic, copy)NSString *loginAccount;

/** 登陆账号token*/
@property (nonatomic, copy)NSString *token;
/** 是否禁言*/
@property (nonatomic) BOOL isShutup;
/** 禁言时间*/
@property (nonatomic, copy)NSString *shutupTime;

/** 是否封号*/
@property (nonatomic) BOOL isBanned;
/** 用户地址*/
@property (nonatomic, copy)NSString *userAddress;
/** 用户手机*/
@property (nonatomic, copy)NSString *userPhone;
/** 用户手机型号*/
@property (nonatomic, copy)NSString *userPhoneVersion;

/** 用户所在省份*/
@property (nonatomic) NSUInteger province;
/** 用户所在区域*/
@property (nonatomic) NSUInteger district;
/** 用户所在城市*/
@property (nonatomic) NSUInteger city;
/**用户描述*/
@property (nonatomic, copy)NSString *userPresentation;
/** 用户等级*/
@property (nonatomic) NSUInteger userLevel;

/** 金币总数*/
@property (nonatomic) NSInteger goldCount;
/** 积分总数*/
@property (nonatomic) NSInteger integralCount;
/** 关注总数*/
@property (nonatomic) NSInteger attentionCount;

/** 关注总数*/
@property (nonatomic)  NSInteger  fans;
/** 是否关注*/
@property (nonatomic)  BOOL  isAttention;
/** 是否是当前登录用户*/
@property (nonatomic)  BOOL  isLogin;


/** 用户身份*/
@property (nonatomic, strong) NSArray  *userRole;
@end
