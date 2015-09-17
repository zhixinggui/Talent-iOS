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
+(void)getMyInfoWithUserAttentionId:(NSNumber *)userAttentionId andMyCenter:(NSNumber *)myCenter success:(void (^)(ZZLoginUser *, ZZNetDataType))success failure:(failureBlock)failure{
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
        ZZLog(@"你妈了个逼Json:%@",json);
        //解析
        [ZZJsonInfoTool parseSelfInfomation:json];
        
        success(nil,ZZNetDataTypeSuccServer);
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
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        ZZLog(@"请求失败");
    }];
    
}
@end
