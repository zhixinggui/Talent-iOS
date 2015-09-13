//
//  ZZConst.h
//  TalentService
//
//  Created by zhizhen on 15/7/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//放全局变量的地方

#import <Foundation/Foundation.h>
typedef enum {
   ZZLoginTypeSmart, //本平台登录
    ZZLoginTypeQQ, //QQ登录
    ZZLoginTypeWeChat,//微信登录
    ZZLoginTypeSina//新浪登录
}ZZLoginType;

typedef enum {
    ZZNetDataTypeSuccLocal, //本地返回成功
    ZZNetDataTypeSuccServer, //服务器返回成功
    ZZNetDataTypeFailServer,//服务器返回失败
    ZZNetDataTypeFailNet,//业务逻辑失败
    ZZNetDataTypeFailLocal//本地返回失败
}ZZNetDataType;
extern  NSString * const baseUrl ;//请求的基本网址
extern  NSTimeInterval const responseTime ;//网络请求响应时常
extern  CGFloat  const  ZZLineSpace ;//行间距
extern  CGFloat  const  ZZCharSpace ;//字间距
extern  CGFloat  const  ZZParagraphSpace ;//段间距
extern  CGFloat  const  ZZEdgeMargin ;//边间距
extern  NSUInteger  const  ZZSecerityTime ;//验证码时常
extern  NSTimeInterval const animationTime;
extern  NSUInteger  const  ZZMiMaMinLenth ;//密码最少位数
extern  NSUInteger  const  ZZMiMaMaxLenth ;//密码最多位数
extern  NSUInteger  const  ZZNickMaxLenth ;//昵称最多位数
extern  CGFloat  const DelayTime;
extern  NSString * const ZZNetLoading ;//连接服务器中