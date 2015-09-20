//
//  ZZHomeHttpTool.h
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZHomeServiceParam.h"
#import "ZZHomeServiceResult.h"
#import "ZZApplyTalentParam.h"
@interface ZZHomeHttpTool : NSObject
/**
 *  推荐达人
 *
 *  @param isRecom <#isRecom description#>
 *  @param succ    <#succ description#>
 *  @param fail    <#fail description#>
 */
+ (void)homeRcommoned:(NSInteger)isRecom  success:(void (^)( NSArray *recoms, ZZNetDataType netDataType))succ  failure:(void (^)(NSString * error, ZZNetDataType netDataType))fail;

/**
 *  首页服务列表
 *
 *  @param param <#param description#>
 *  @param succ  <#succ description#>
 *  @param fail  <#fail description#>
 */
+ (void)homeServices:(ZZHomeServiceParam *)homeParam success:(void (^)(ZZHomeServiceResult *result, ZZNetDataType netDataType))succ  failure:(void (^)(NSString * error, ZZNetDataType netDataType))fail;

/**
 *  达人申请
 *
 *  @param applyParam <#applyParam description#>
 *  @param succ       <#succ description#>
 *  @param fail       <#fail description#>
 */
+ (void)homeApply:(ZZApplyTalentParam *)applyParam success:(void (^)(id *result, ZZNetDataType netDataType))succ  failure:(void (^)(NSString * error, ZZNetDataType netDataType))fail;
@end
