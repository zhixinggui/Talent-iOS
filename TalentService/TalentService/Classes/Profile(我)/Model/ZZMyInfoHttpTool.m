//
//  ZZMyInfoHttpTool.m
//  TalentService
//
//  Created by charles on 15/9/15.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZMyInfoHttpTool.h"
#import "ZZLoginUserTool.h"
#import "ZZHttpTool.h"
#import "ZZJsonInfoTool.h"

@implementation ZZMyInfoHttpTool
/**
 *  获取个人信息
 *
 *  @param userAttentionId <#userAttentionId description#>
 *  @param myCenter        <#myCenter description#>
 *  @param success         <#success description#>
 *  @param failure         <#failure description#>
 */
+(void)getMyInfoWithUserAttentionId:(NSNumber *)userAttentionId andMyCenter:(NSNumber *)myCenter success:(void (^)(ZZLoginUser *loginUser, ZZNetDataType))success failure:(failureBlock)failure{
    ZZInfoParam *infoParam = [[ZZInfoParam alloc]init];
    infoParam.cmd = @"smart/personal/getPersonal";
    infoParam.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    if (userAttentionId) {
        [dic setValue:userAttentionId forKey:@"userAttentionId"];
    }
    if (myCenter) {
        [dic setValue:myCenter forKey:@"myCenter"];
    }
    infoParam.parameters = dic;
    [ZZHttpTool afPostByApiName:@"" Params:infoParam success:^(id json) {
        ZZLog(@"你Json:%@",json);
        //解析
        ZZLoginUser *loginUser = [ZZJsonInfoTool parseSelfInfomation:json];
        
        success(loginUser,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        failure(error,netDataType);
        ZZLog(@"个人信息请求失败");
    }];
}


/**
 *  修改个人信息
 */
+(void)changeInfoWithChangeInfoParam:(ZZChangeInfoParam *)changeInfoParam success:(void (^)(ZZLoginUser *, ZZNetDataType))success failure:(failureBlock)failure{
    
    ZZParam *param = [[ZZParam alloc]init];
    
    param.cmd = @"smart/personal/updatePersonal";
    
    param.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
    
    param.parameters = [changeInfoParam keyValues];
    
    [ZZHttpTool afPostByApiName:@"" Params:param success:^(id json) {
        ZZLog(@"个人信息:%@",json);
        //解析
        [ZZJsonInfoTool parseChangeInformation:json];
        ZZLog(@"个人信息:%@",json);
        success(nil,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        ZZLog(@"请求失败");
    }];
    
}

/**
 *  获取我的服务收藏
 */
+(void)getMyCollectActivityWithPageNo:(NSInteger)pageNo andNumberOfPerPage:(NSInteger)numberOfPerPage success:(void (^)(ZZHomeServiceResult *result, ZZNetDataType))success failure:(failureBlock)failure{
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/personal/getServiceCollect";
    param.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
    param.parameters = @{@"pageNo":@(pageNo),@"numberOfPerPage":@(numberOfPerPage)};
    [ZZHttpTool afPostByApiName:@"" Params:param success:^(id json) {
        ZZLog(@"我的收藏:%@",json);
        ZZHomeServiceResult *serviceResult = [ZZHomeServiceResult  objectWithKeyValues:json];
        success (serviceResult, ZZNetDataTypeSuccLocal);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        
    }];
    
}
/**
 *  关注列表
 */
+(void)getMyAttentionWithTypeNum:(NSInteger)typeNum andPageNo:(NSInteger)pageNo andNumberOfPerPage:(NSInteger)numberOfPerPage success:(void (^)(ZZAttentionResult *attResult, ZZNetDataType))success failure:(failureBlock)failure{
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/attention/getList";
    param.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
    param.parameters = @{@"typeNum":@(typeNum),@"pageNo":@(pageNo),@"numberOfPerPage":@(numberOfPerPage)};
    [ZZHttpTool afPostByApiName:@"" Params:param success:^(id json) {
        ZZLog(@"关注列表%@",json);
        ZZAttentionResult *attResult = [ZZAttentionResult objectWithKeyValues:json];
        success(attResult,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        ZZLog(@"请求失败");
    }];
}
/**
 *  关注取消列表
 */
+(void)attentionOrCancelWithUserAttentionId:(NSInteger)userAttentionId success:(void (^)(ZZOtherUser *otherUser, ZZNetDataType))success failure:(failureBlock)failure{
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/attention/attentionUser";
    param.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
    param.parameters = @{@"userAttentionId":@(userAttentionId)};
    [ZZHttpTool afPostByApiName:@"" Params:param success:^(id json) {
        ZZLog(@"关注或取消:%@",json);
        success(json,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        ZZLog(@"请求失败");
    }];
}
@end
