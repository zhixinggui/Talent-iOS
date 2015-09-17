//
//  ZZConst.m
//  TalentService
//
//  Created by zhizhen on 15/7/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString * const baseUrl = @"http://192.168.100.155:8081/wine-rest/cgi";

NSTimeInterval const responseTime = 60;
CGFloat  const  ZZLineSpace = 4;//行间距
CGFloat  const  ZZCharSpace = 1;//字间距
CGFloat  const  ZZParagraphSpace = 3;//段间距
CGFloat  const  ZZEdgeMargin = 8;//边间距
NSUInteger  const  ZZSecerityTime = 60 ;//验证码时常
NSTimeInterval const animationTime = 0.25;
NSUInteger  const  ZZMiMaMinLenth = 6 ;//密码最少位数
NSUInteger  const  ZZMiMaMaxLenth  = 16;//密码最多位数
NSUInteger  const  ZZNickMaxLenth  = 14;//昵称最多位数
CGFloat  const DelayTime = 0.1;
NSString * const ZZNetLoading  = @"连接服务器中";//连接服务器中
NSString * const ZZRefreshFail  = @"刷新失败，请稍候重试";//刷新失败提示
NSString * const ZZUserNickChangeNoti = @"ZZUserNickChangeNoti";