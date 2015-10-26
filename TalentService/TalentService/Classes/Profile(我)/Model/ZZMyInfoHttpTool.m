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
#import "ZZUploadImageTool.h"
@implementation ZZMyInfoHttpTool
/**
 *  获取个人信息
 *
 *  @param userAttentionId <#userAttentionId description#>
 *  @param myCenter        <#myCenter description#>
 *  @param success         <#success description#>
 *  @param failure         <#failure description#>
 */
+(void)getMyInfoWithUserAttentionId:(NSNumber *)userAttentionId andMyCenter:(NSNumber *)myCenter success:(void (^)(ZZOtherUser *loginUser, ZZNetDataType))success failure:(failureBlock)failure{
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
    [ZZHttpTool afPostByApiName:@"" Params:infoParam success:^(ZZBottomNetResult *json) {
        ZZLog(@"个人信息Json:%@",json.response.data);
        //解析
        ZZOtherUser *otherUser = [ZZOtherUser objectWithKeyValues:json.response.data];
        success(otherUser,ZZNetDataTypeSuccServer);
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
    
    [ZZHttpTool afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
        //解析
        [ZZJsonInfoTool parseChangeInformation:json.response.data];
        ZZLog(@"个人信息:%@",json.response.data);
        success(nil,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        failure(error,netDataType);
        ZZLog(@"请求失败");
    }];
    
}

/**
 *  获取我的服务收藏
 */
+(void)getMyCollectActivityWithCollectParam:(ZZCollectParam *)collectParam success:(void (^)(ZZHomeServiceResult *result, ZZNetDataType))success failure:(failureBlock)failure{
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/personal/getServiceCollect";
    param.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
    param.parameters = [collectParam keyValues];
    [ZZHttpTool afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
        ZZLog(@"我的收藏:%@",json);
        ZZHomeServiceResult *serviceResult = [ZZHomeServiceResult  objectWithKeyValues:json.response.data];
        success (serviceResult, ZZNetDataTypeSuccLocal);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        failure(error,netDataType);
    }];
    
}
/**
 *  关注列表
 */
+(void)getMyAttentionWithAttentionParam:(ZZAttentionParam *)attentionParam success:(void (^)(ZZAttentionResult *attResult, ZZNetDataType))success failure:(failureBlock)failure{
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/attention/getList";
    param.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
    param.parameters = [attentionParam keyValues];
    [ZZHttpTool afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
        ZZLog(@"关注列表%@",json);
        ZZAttentionResult *attResult = [ZZAttentionResult objectWithKeyValues:json.response.data];
        success(attResult,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        failure(error,netDataType);
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
    [ZZHttpTool afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
        ZZLog(@"关注或取消:%@",json);
        success(json.response.data,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        failure(error,netDataType);
        ZZLog(@"请求失败");
    }];
}
/**
 *我的订单列表
 */
+ (void)getMyOrderListWithOrderParam:(ZZOrderParam *)orderParam success:(void (^)(ZZOrderResult *orderResult, ZZNetDataType))success failure:(failureBlock)failure {
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/order/getMyOrder";
    param.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
    param.parameters = [orderParam keyValues];
    [ZZHttpTool afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
        ZZLog(@"我的订单列表:%@",json);
        ZZOrderResult *orderResult = [ZZOrderResult objectWithKeyValues:json.response.data];
        success(orderResult,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        ZZLog(@"请求失败");
        failure(error,netDataType);
        
    }];
}
/**
 *我的服务
 */
+ (void)getmyServiceListWithMyServiceParam:(ZZMyServiceParam *)myServiceParam success:(void (^)(ZZHomeServiceResult *, ZZNetDataType))success failure:(failureBlock)failure {
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/personal/getService";
    param.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
    param.parameters = [myServiceParam keyValues];
    [ZZHttpTool afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
        ZZLog(@"我的服务:%@",json);
        ZZHomeServiceResult *serviceResult = [ZZHomeServiceResult  objectWithKeyValues:json.response.data];
        success (serviceResult, ZZNetDataTypeSuccLocal);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        ZZLog(@"请求失败");
        failure(error,netDataType);
    }];
}

/**
 *验证订单
 */
+ (void)testOrderWithTestOrderParam:(ZZTestOrderParam *)testOrderParam success:(void (^)(id, ZZNetDataType))success failure:(failureBlock)failure{
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/order/validateOrder";
    param.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
    param.parameters = [testOrderParam keyValues];
    [ZZHttpTool afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
        ZZLog(@"验证订单:%@",json);
        success (json.response.data, ZZNetDataTypeSuccLocal);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        ZZLog(@"请求失败");
        failure(error,netDataType);
    }];
}

/**
 *头像上传
 */
+ (void)commitHeadImageWithImageArray:(NSArray*)imageArray ChangeInfoParam:(ZZChangeInfoParam *)changeInfoParam success:(void (^)(ZZLoginUser *, ZZNetDataType))success failure:(failureBlock)failure {
    //上传头像
    [[ZZUploadImageTool sharedTool] upLoadImages:imageArray success:^(NSUInteger succCount) {
        ZZLog(@".......");
        ZZParam *param = [[ZZParam alloc]init];
        param.cmd = @"smart/personal/updatePersonal";
        param.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
        ZZUploadImageModel *imageModel = imageArray[0];
        changeInfoParam.imgPath = imageModel.url;
        changeInfoParam.imgWidth = imageModel.width;
        changeInfoParam.imgHeight = imageModel.height;
        param.parameters = [changeInfoParam keyValues];
        [ZZHttpTool afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
            ZZLog(@"上传成功:%@",json);
            //解析
            [ZZJsonInfoTool parseChangeInformation:json.response.data];
            success (nil, ZZNetDataTypeSuccLocal);
        } failure:^(NSString *error, ZZNetDataType netDataType) {
            ZZLog(@"请求失败");
            failure(error,netDataType);
        }];
    } failure:^(NSUInteger failCount) {
        failure(@"图片上传失败",ZZNetDataTypeUpLoadImageFail);
    }];
}
/**
 *背景图片
 */
+ (void)commitBackgroundImageWithImageArray:(NSArray *)imageArray success:(void (^)(ZZLoginUser *, ZZNetDataType))success failure:(failureBlock)failure {
    
    [[ZZUploadImageTool sharedTool] upLoadImages:imageArray success:^(NSUInteger succCount) {
        
        ZZParam *param = [[ZZParam alloc]init];
        param.cmd = @"smart/personal/updateBackgroundImg";
        param.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
        ZZUploadImageModel *imageModel = imageArray[0];
        ZZChangeInfoParam *changeInfoParam = [[ZZChangeInfoParam alloc]init];
        changeInfoParam.imgPath = imageModel.url;
        changeInfoParam.imgWidth = imageModel.width;
        changeInfoParam.imgHeight = imageModel.height;
        param.parameters = [changeInfoParam keyValues];
        [ZZHttpTool afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
            ZZLog(@"上传成功:%@",json.response.data);
            //解析
            [ZZJsonInfoTool parseChangeInformation:json.response.data];
            success (nil, ZZNetDataTypeSuccLocal);
        } failure:^(NSString *error, ZZNetDataType netDataType) {
            ZZLog(@"请求失败");
            failure(error,netDataType);
        }];
    } failure:^(NSUInteger failCount) {
        failure(@"图片上传失败",ZZNetDataTypeUpLoadImageFail);
    }];
    
    
}

+ (void)signOutAppSuccess:(void(^)(ZZLoginUser *infoUser, ZZNetDataType dataType))success failure:(failureBlock)failure {
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/logout";
    param.token = [ZZLoginUserTool sharedZZLoginUserTool].loginUser.token;
    [ZZHttpTool afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
        success(json.response.data,ZZNetDataTypeSuccLocal);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        failure (error, netDataType);
    }];
}

@end
