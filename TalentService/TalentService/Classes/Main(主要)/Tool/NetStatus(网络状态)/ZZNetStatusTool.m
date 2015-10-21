//
//  ZZNetStatusTool.m
//  TalentService
//
//  Created by zhizhen on 15/10/21.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZNetStatusTool.h"
#import "AFNetworkReachabilityManager.h"
@implementation ZZNetStatusTool
+(void)load{
   //一定要开始检测
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    [netWorkManager setReachabilityStatusChangeBlock :^ (AFNetworkReachabilityStatus status) {
        switch (status) {
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break ;
                
            case AFNetworkReachabilityStatusNotReachable:
                break ;

            default:
                break ;
        }
        
    }];
    
    [netWorkManager  startMonitoring];
}
@end
