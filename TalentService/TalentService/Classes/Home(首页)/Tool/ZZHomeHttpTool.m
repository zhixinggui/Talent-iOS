//
//  ZZHomeHttpTool.m
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZHomeHttpTool.h"
#import "ZZHttpTool.h"
#import "ZZLoginUser.h"

@implementation ZZHomeHttpTool
+(void)homeRcommoned:(NSInteger)isRecom success:(void (^)(NSArray *, ZZNetDataType))succ failure:(void (^)(NSString *, ZZNetDataType))fail{
    
    ZZParam *param = [[ZZParam  alloc]init];
    param.cmd = @"smart/recommonedEredar";
    param.parameters = @{@"isRecommoned":@(isRecom)};
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
        ZZLog(@".%@",json);
        NSArray *array = [ZZLoginUser objectArrayWithKeyValuesArray:json.response.data];
    
        succ(array,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        
         fail (error, netDataType);
    }];
    
}

+(void)homeServices:(ZZHomeServiceParam *)homeParam success:(void (^)(ZZHomeServiceResult *result, ZZNetDataType netDataType))succ failure:(void (^)(NSString *, ZZNetDataType))fail{
    
    ZZParam *param = [[ZZParam  alloc]init];
    param.cmd = @"smart/services/getPage";
    param.parameters = homeParam.keyValues;
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
          ZZLog(@",,%@",[NSThread currentThread]);
          ZZLog(@".%@",json);
          ZZLog(@",,%@",[NSThread currentThread]);
        ZZHomeServiceResult *serviceResult = [ZZHomeServiceResult  objectWithKeyValues:json.response.data];
        succ (serviceResult, ZZNetDataTypeSuccLocal);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        fail (error, netDataType);
        
    }];
}

+(void)homeApply:(ZZApplyTalentParam *)applyParam success:(void (^)( id result, ZZNetDataType))succ failure:(void (^)(NSString *, ZZNetDataType))fail{
    
    ZZParam *param = [[ZZParam  alloc]init];
    param.cmd = @"smart/eredar/apply";
    param.parameters = applyParam.keyValues;
    param.token = [ZZLoginUserTool  sharedZZLoginUserTool].loginUser.token;
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
        succ (json.response.data,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        fail(error ,netDataType);
    }];
}
@end
