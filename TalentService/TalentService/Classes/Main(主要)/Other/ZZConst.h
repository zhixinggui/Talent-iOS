//
//  ZZConst.h
//  TalentService
//
//  Created by zhizhen on 15/7/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//放全局变量的地方

#import <Foundation/Foundation.h>
//登陆类型
typedef enum {
   ZZLoginTypeSmart, //本平台登录
    ZZLoginTypeQQ, //QQ登录
    ZZLoginTypeWeChat,//微信登录
    ZZLoginTypeSina//新浪登录
}ZZLoginType;
//数据请求类型
typedef enum {
    ZZNetDataTypeSuccLocal, //本地返回成功
    ZZNetDataTypeSuccServer, //服务器返回成功
    ZZNetDataTypeFailServer,//服务器返回失败
    ZZNetDataTypeFailNet,//业务逻辑失败
    ZZNetDataTypeFailLocal,//本地返回失败
    ZZNetDataTypeUpLoadImageFail//本地返回失败
}ZZNetDataType;

//活动状态
typedef enum {
    ZZActivityStatusTypeAll= 0,//全部
   ZZActivityStatusTypeNoStart,//未开始
    ZZActivityStatusTypeDidStart ,//已开始
    ZZActivityStatusTypeDidEnd//已结束
}ZZActivityStatusType;
//订单类型
typedef  enum{
    ZZOrderTypeAll = 1,//全部
    ZZOrderTypeNoPay,//未付款
    ZZOrderTypeDidPay,//未消费
    ZZOrderTypeDidJoin,//待评价
    ZZOrderTypeDidPast,//退款
    ZZOrderTypeDidTest,//已验证
    ZZOrderTypeNoTest,//未验证
}ZZOrderType;
//订单状态
typedef enum {
    /**未支付*/
    ZZOrderStatusNotPaid = 1,
    /**已支付*/
    ZZOrderStatusPaid,
    /**已参加*/
    ZZOrderStatusComplete,
    /**已过期*/
    ZZOrderStatusExpired,
    /**已评价*/
    ZZOrderStatusEvaluation,
    /**已退款*/
    ZZOrderStatusRefund,
    /**已取消*/
    ZZOrderStatusCancel,
}ZZOrderStatus;


/**网络请求地址*/
extern  NSString * const baseUrl ;//请求的基本网址
/**网络请求时长*/
extern  NSTimeInterval const responseTime ;//网络请求响应时常
/**提示语言*/
extern  NSString * const ZZNetLoading ;//连接服务器中
extern  NSString * const ZZRefreshFail; // 刷新失败提示
/**通知*/
extern  NSString * const ZZUserNickChangeNoti; // 登录用户头像改变通知
extern  NSString * const ZZTokenIsNoActive; //token失效
extern  NSString * const ZZTokenIsNoActiveError; //token失效通知里userinfo的信息

/**文字间距*/
extern  CGFloat  const  ZZLineSpace ;//行间距
extern  CGFloat  const  ZZCharSpace ;//字间距
extern  CGFloat  const  ZZParagraphSpace ;//段间距
/**边距*/
extern  CGFloat  const  ZZEdgeMargin ;//边间距
extern  CGFloat  const DelayTime;
/**长度*/
extern  NSTimeInterval const animationTime;
extern  NSUInteger  const  ZZMiMaMinLenth ;//密码最少位数
extern  NSUInteger  const  ZZMiMaMaxLenth ;//密码最多位数
extern  NSUInteger  const  ZZNickMaxLenth ;//昵称最多位数
extern  NSUInteger  const  ZZSecerityTime ;//验证码时长
