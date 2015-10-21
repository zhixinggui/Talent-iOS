//
//  ZZNetStatusTool.h
//  TalentService
//
//  Created by zhizhen on 15/10/21.
//  Copyright © 2015年 zhizhen. All rights reserved.
//  把AFNetworkReachabilityManager的网络状态封装起来

#import <Foundation/Foundation.h>

@interface ZZNetStatusTool : NSObject

+ (BOOL)isReachable;
@end
