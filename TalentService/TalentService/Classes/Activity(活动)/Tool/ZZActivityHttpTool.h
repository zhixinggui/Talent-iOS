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
@interface ZZActivityHttpTool : NSObject

/**服务详情*/
+ (void)activityDetail:(NSUInteger)activityID  success:(void(^)(ZZActivity *detailActivity,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail;

/**服务预定*/
+ (void)activityBook:(NSUInteger)activityID  success:(void(^)(ZZOrder *order,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail;

/**服务收藏*/
+ (void)activityCollect:(NSUInteger )activityID collect:(BOOL) isCollect success:(void(^)(id json,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail;
@end
