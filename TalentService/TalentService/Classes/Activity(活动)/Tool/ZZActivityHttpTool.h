//
//  ZZActivityHttpTool.h
//  TalentService
//
//  Created by 张亮亮 on 15/9/11.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZActivity.h"
#import "ZZOrder.h"
#import "ZZActivityConmitParam.h"
#import "ZZActivityListParam.h"
#import "ZZActivityListResult.h"
@interface ZZActivityHttpTool : NSObject

/**服务模块列表*/
+ (void)activityList: (ZZActivityListParam *)listParam success:(void(^)(ZZActivityListResult *listResult ,ZZNetDataType  netSuccType))succ failure:(void(^)(NSString *error, ZZNetDataType  netFailType))fail;

/**服务详情*/
+ (void)activityDetail:(NSInteger)activityID  success:(void(^)(ZZActivity *detailActivity,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail;

/**服务预定*/
+ (void)activityBook:(NSInteger)activityID  success:(void(^)(ZZOrder *order,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail;

/**服务收藏*/
+ (void)activityCollect:(NSInteger )activityID collect:(BOOL) isCollect success:(void(^)(id json,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail;

/**提交订单*/
+ (void)activityCommitOrder:(ZZActivityConmitParam *)commitParam success:(void(^)(ZZOrder *order,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail;

/**查看订单*/
+ (void)activitySeeOrder:(NSString *)orderCode  success:(void(^)(ZZOrder *order ,ZZNetDataType netDataType))succ  failure:(void (^)(NSString *error , ZZNetDataType netDataType))fail;

/**取消订单*/
+ (void)activityCancellOrder:(NSString *)orderCode  success:(void(^)(id json ,ZZNetDataType netDataType))succ  failure:(void (^)(NSString *error , ZZNetDataType netDataType))fail;
@end
