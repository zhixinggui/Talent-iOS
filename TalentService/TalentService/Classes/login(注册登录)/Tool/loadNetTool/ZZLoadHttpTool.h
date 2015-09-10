//
//  ZZLoadHttpTool.h
//  TalentService
//
//  Created by zhizhen on 15/9/9.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZResignParam.h"
#import "ZZLoginParam.h"
#import "ZZLoginUser.h"
typedef void(^successBlock)(id json, ZZNetDataType dataType);
typedef void(^errorBlock)(NSString *error , ZZNetDataType dataType);
@interface ZZLoadHttpTool : NSObject
/**
 *  注册
 *
 *  @param param   请求参数
 *  @param success <#success description#>
 *  @param error   <#error description#>
 */
+ (void)loadResign:(ZZResignParam *)resignParam success:(void (^)(ZZLoginUser *loginUser ,ZZNetDataType netDataType))success  failure:(errorBlock)failure;

/**
 *  登录
 *
 *  @param param   请求参数
 *  @param success <#success description#>
 *  @param error   <#error description#>
 */
+ (void)loadLogin:(ZZLoginParam *)loginParam success:(void (^)(ZZLoginUser *loginUser ,ZZNetDataType netDataType))success  failure:(errorBlock)failure;
/**
 *  获取注册验证码
 *
 *  @param loginAccount <#loginAccount description#>
 *  @param success      <#success description#>
 *  @param error        <#error description#>
 */
+ (void)loadGetResignCode:(NSString *)loginAccount success:(successBlock)success  failure:(errorBlock)failure;

/**
 *  验证验证码
 *
 *  @param loginAccount <#loginAccount description#>
 *  @param securityCode <#securityCode description#>
 *  @param success      <#success description#>
 *  @param error        <#error description#>
 */
+ (void)loadVerifyCode:(NSString *)loginAccount code:(NSString *)securityCode success:(successBlock)success  failure:(errorBlock)failure;

/**
 *  忘记密码
 *
 *  @param loginAccoun   <#loginAccoun description#>
 *  @param loginPassword <#loginPassword description#>
 *  @param success       <#success description#>
 *  @param failure       <#failure description#>
 */
+ (void)loadForgetPWD:(NSString *)loginAccount  word:(NSString *)loginPassword success:(void (^)(ZZLoginUser *loginUser ,ZZNetDataType netDataType))success  failure:(errorBlock)failure;


/**
 *  获取验证码
 *
 *  @param loginAccount <#loginAccount description#>
 *  @param success      <#success description#>
 *  @param error        <#error description#>
 */
+ (void)loadGetCode:(NSString *)loginAccount success:(successBlock)success  failure:(errorBlock)failure;
@end
