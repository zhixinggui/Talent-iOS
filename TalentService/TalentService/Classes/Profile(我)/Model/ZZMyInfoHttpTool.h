//
//  ZZMyInfoHttpTool.h
//  TalentService
//
//  Created by charles on 15/9/15.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZInfoParam.h"
#import "ZZLoginUserTool.h"
#import "ZZChangeInfoParam.h"
#import "ZZActivity.h"
#import "ZZOtherUser.h"
#import "ZZAttentionResult.h"
typedef void (^successBlock)(id json, ZZNetDataType dataType);
typedef void (^failureBlock)(NSString *error , ZZNetDataType datatype);
@interface ZZMyInfoHttpTool : NSObject
/**
 *  个人中心(我的)
 */
+(void)getMyInfoWithUserAttentionId:(NSNumber *)userAttentionId andMyCenter:(NSNumber *)myCenter success:(void(^)(ZZLoginUser *infoUser, ZZNetDataType dataType))success failure:(failureBlock)failure;


/**
 *  修改个人信息
 */
+(void)changeInfoWithChangeInfoParam:(ZZChangeInfoParam*)changeInfoParam success:(void(^)(ZZLoginUser *infoUser, ZZNetDataType dataType))success failure:(failureBlock)failure;

/**
 *  我的服务收藏
 */
+(void)getMyCollectActivityWithPageNo:(NSInteger)pageNo andNumberOfPerPage:(NSInteger)numberOfPerPage success:(void(^)(ZZActivity *activity, ZZNetDataType dataType))success failure:(failureBlock)failure;

/**
 *  我的关注列表
 */
+(void)getMyAttentionWithTypeNum:(NSInteger)typeNum andPageNo:(NSInteger)pageNo andNumberOfPerPage:(NSInteger)numberOfPerPage
 success:(void(^)(ZZAttentionResult *attResult, ZZNetDataType dataType))success failure:(failureBlock)failure;
@end
