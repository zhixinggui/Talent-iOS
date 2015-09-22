//
//  ZZActivityHttpTool.m
//  TalentService
//
//  Created by 张亮亮 on 15/9/11.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityHttpTool.h"
#import "ZZHttpTool.h"
@implementation ZZActivityHttpTool
+ (void)activityDetail:(NSUInteger)activityID  success:(void(^)(ZZActivity *detailActivity,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail{
    
    ZZParam *param = [[ZZParam  alloc]init];
    param.cmd = @"smart/services/getServicesDetails";
    param.token = [ZZLoginUserTool  sharedZZLoginUserTool].loginUser.token;
    param.parameters = @{@"id":@(activityID)};
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        
        ZZActivity *activity = [ZZActivity  objectWithKeyValues:json];
        succ(activity,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        fail(error, netDataType);
    }];
}

+ (void)activityBook:(NSUInteger)activityID  success:(void(^)(id json,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail{
    
    ZZParam *param = [[ZZParam  alloc]init];
    param.cmd = @"smart/services/Reserve";
    param.token = [ZZLoginUserTool  sharedZZLoginUserTool].loginUser.token;
    param.parameters = @{@"serviceId":@(activityID)};
    
    
    
}
@end
