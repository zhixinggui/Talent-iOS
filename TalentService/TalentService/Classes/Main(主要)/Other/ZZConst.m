//
//  ZZConst.m
//  TalentService
//
//  Created by zhizhen on 15/7/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**网络本地测试请求地址*/

NSString * const baseUrl = @"http://192.168.100.120:8081/wine-rest/cgi";
/**网络阿里云请求地址*/
//NSString * const baseUrl = @"http://mengbaopai.smart-kids.com:82/wine-rest/cgi";

/**网络请求时长*/
NSTimeInterval const responseTime = 60;

/**提示语言*/
NSString * const ZZNetLoading  = @"连接服务器中";//连接服务器中
NSString * const ZZRefreshFail  = @"刷新失败，请稍候重试";//刷新失败提示

/**通知*/
NSString * const ZZUserNickChangeNoti = @"ZZUserNickChangeNoti";
NSString * const ZZMyAttentionNoti = @"ZZMyAttentionNoti";
NSString * const ZZMyCollectionNoti = @"ZZMyCollectionNoti";
NSString * const ZZTokenIsNoActive = @"ZZTokenIsNoActive"; //token失效
NSString * const ZZTokenIsNoActiveError = @"ZZTokenIsNoActiveError"; //token失效通知里userinfo的信息

/**文字间距*/
CGFloat  const  ZZLineSpace = 5;//行间距
CGFloat  const  ZZCharSpace = 1;//字间距
CGFloat  const  ZZParagraphSpace = 3;//段间距

/**边距*/
CGFloat  const  ZZEdgeMargin = 8;//边间距

/**长度*/
NSUInteger  const  ZZSecerityTime = 60 ;//验证码时常
NSTimeInterval const animationTime = 0;
NSUInteger  const  ZZMiMaMinLenth = 6 ;//密码最少位数
NSUInteger  const  ZZMiMaMaxLenth  = 16;//密码最多位数
NSUInteger  const  ZZNickMaxLenth  = 14;//昵称最多位数
CGFloat  const DelayTime = 0.1;

