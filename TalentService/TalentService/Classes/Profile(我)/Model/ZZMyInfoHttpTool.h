//
//  ZZMyInfoHttpTool.h
//  TalentService
//
//  Created by charles on 15/9/15.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZInfoParam.h"
#import "ZZCollectParam.h"
#import "ZZAttentionParam.h"
#import "ZZOrderParam.h"
#import "ZZTestOrderParam.h"

#import "ZZLoginUserTool.h"
#import "ZZChangeInfoParam.h"
#import "ZZActivity.h"
#import "ZZOtherUser.h"
#import "ZZAttentionResult.h"
#import "ZZHomeServiceResult.h"
#import "ZZOrderResult.h"
#import "ZZMyServiceParam.h"
typedef void (^successBlock)(id json, ZZNetDataType dataType);
typedef void (^failureBlock)(NSString *error , ZZNetDataType datatype);
@interface ZZMyInfoHttpTool : NSObject
/**
 *  个人中心(我的)
 */
+(void)getMyInfoWithUserAttentionId:(NSNumber *)userAttentionId andMyCenter:(NSNumber *)myCenter success:(void(^)(ZZOtherUser *infoUser, ZZNetDataType dataType))success failure:(failureBlock)failure;


/**
 *  修改个人信息
 */
+(void)changeInfoWithChangeInfoParam:(ZZChangeInfoParam*)changeInfoParam success:(void(^)(ZZLoginUser *infoUser, ZZNetDataType dataType))success failure:(failureBlock)failure;

/**
 *  我的服务收藏
 */
+(void)getMyCollectActivityWithCollectParam:(ZZCollectParam *)collectParam success:(void(^)(ZZHomeServiceResult *result, ZZNetDataType dataType))success failure:(failureBlock)failure;

/**
 *  我的关注列表
 */
+(void)getMyAttentionWithAttentionParam:(ZZAttentionParam *)attentionParam
 success:(void(^)(ZZAttentionResult *attResult, ZZNetDataType dataType))success failure:(failureBlock)failure;

/**
 *  关注/取消关注某人
 */
+(void)attentionOrCancelWithUserAttentionId:(NSInteger)userAttentionId success:(void(^)(ZZOtherUser *otherUser, ZZNetDataType dataType))success failure:(failureBlock)failure;

/**
 *  我的订单列表
 */
+ (void)getMyOrderListWithOrderParam:(ZZOrderParam *)orderParam
                          success:(void(^)(ZZOrderResult *orderResult, ZZNetDataType dataType))success
                          failure:(failureBlock)failure;

/**
 *  我的服务列表/达人服务列表
 */
+ (void)getmyServiceListWithMyServiceParam:(ZZMyServiceParam *)myServiceParam success:(void(^)(ZZHomeServiceResult *result, ZZNetDataType dataType))success failure:(failureBlock)failure;
/**
 *  订单验证
 */
+ (void)testOrderWithTestOrderParam:(ZZTestOrderParam *)testOrderParam success:(void(^)(id json, ZZNetDataType dataType))success failure:(failureBlock)failure;

/**
 *  头像上传
 */
+ (void)commitHeadImageWithImageArray:(NSArray*)imageArray  ChangeInfoParam:(ZZChangeInfoParam*)changeInfoParam success:(void(^)(ZZLoginUser *infoUser, ZZNetDataType dataType))success failure:(failureBlock)failure;

/**
 *背景图片
 */
+ (void)commitBackgroundImageWithImageArray:(NSArray*)imageArray success:(void(^)(ZZLoginUser *infoUser, ZZNetDataType dataType))success failure:(failureBlock)failure;
@end



