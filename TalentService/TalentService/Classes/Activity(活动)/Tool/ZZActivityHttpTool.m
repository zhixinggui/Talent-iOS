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
+ (void)activityDetail:(NSInteger)activityID  success:(void(^)(ZZActivity *detailActivity,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail{
    
    ZZParam *param = [[ZZParam  alloc]init];
    param.cmd = @"smart/services/getServicesDetails";
    param.token = ZZLoginTool.loginToken;
    param.parameters = @{@"id":@(activityID)};
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        
        ZZActivity *activity = [ZZActivity  objectWithKeyValues:json];
        succ(activity,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        fail(error, netDataType);
    }];
}

+ (void)activityBook:(NSInteger)activityID  success:(void(^)(ZZOrder *order,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail{
    
    ZZParam *param = [[ZZParam  alloc]init];
    param.cmd = @"smart/services/Reserve";
    param.token = ZZLoginTool.loginToken;
    param.parameters = @{@"serviceId":@(activityID)};
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        
        ZZOrder *order = [ZZOrder objectWithKeyValues:json];
        succ(order,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        fail (error,netDataType);
    }];
    
}

+ (void)activityCollect:(NSInteger )activityID collect:(BOOL) isCollect success:(void(^)(id json,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail{
    
    ZZParam *param = [[ZZParam  alloc]init];
    param.cmd = @"smart/services/serviceCollect";
    param.token = ZZLoginTool.loginToken;
    NSInteger collect = isCollect ? 1:0;
    param.parameters = @{@"id":@(activityID),@"isCollect":@(collect)};
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        succ(json,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        fail(error,netDataType);
    }];
}

+ (void)activityCommitOrder:(ZZActivityConmitParam *)commitParam success:(void(^)(id json,  ZZNetDataType  netSuccType ))succ  failure:(void(^)(NSString *error , ZZNetDataType  netFialType))fail{
    
    ZZParam *param = [[ZZParam  alloc]init];
    param.cmd = @"smart/services/commitOrder";
    param.token = ZZLoginTool.loginToken;
    param.parameters = [commitParam  keyValues];
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        
        succ(json,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        fail(error,netDataType);
    }];
}

/**查看订单*/
+ (void)activitySeeOrder:(NSString *)orderCode  success:(void(^)(id json ,ZZNetDataType netDataType))succ  failure:(void (^)(NSString *error , ZZNetDataType netDataType))fail{
    
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/order/getOrderDetails";
    param.token = ZZLoginTool.loginToken;
    param.parameters = @{@"orderCode":orderCode};
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        succ(json,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        fail(error,netDataType);
    }];
}

/**取消订单*/
+ (void)activityCancellOrder:(NSString *)orderCode  success:(void(^)(id json ,ZZNetDataType netDataType))succ  failure:(void (^)(NSString *error , ZZNetDataType netDataType))fail{
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/order/cancelOrder";
    param.token = ZZLoginTool.loginToken;
    param.parameters = @{@"orderCode":orderCode};
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        succ(json,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        fail(error,netDataType);
    }];
}
@end
