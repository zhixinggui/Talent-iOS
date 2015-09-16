//
//  ZZLoadHttpTool.m
//  TalentService
//
//  Created by zhizhen on 15/9/9.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//
NSUInteger const DeviceType =1;
#import "ZZLoadHttpTool.h"
#import "ZZHttpTool.h"
#import "ZZAppSystem.h"
#import "ZZLoginUser.h"
@implementation ZZLoadHttpTool
/**注册*/
+ (void)loadResign:(ZZResignParam *)resignParam success:(void (^)(ZZLoginUser *loginUser ,ZZNetDataType netDataType))success  failure:(errorBlock)failure{
    
    resignParam.device = @(DeviceType);
    resignParam.deviceVersion = [ZZAppSystem  appVersion];
    resignParam.model  = [ZZAppSystem appPlatform];
    resignParam.imei = [ZZAppSystem  appUDID];
    resignParam.applicationVersion = [ZZAppSystem  appVersion];
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/register";
    param.parameters = [resignParam keyValues];
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        //判断请求是成功还是失败
        ZZLoginUser *user = [ZZLoginUser  objectWithKeyValues:json];
            success(user,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType  netDataType) {
        
        failure(error,netDataType);
    }];
    /*
     response = {
     status = 1,
     data = {
     loginTime = 2015-09-10 10:55:02,
     userBigHeight = <null>,
     userBigImg = <null>,
     province = 110000,
     userPhone = <null>,
     userSex = <null>,
     district = 110101,
     isShutup = 0,
     userSmallWidth = <null>,
     city = 110100,
     userPresentation = <null>,
     userSmallHeight = <null>,
     loginAccountType = 0,
     userPhoneVersion = <null>,
     userLevel = 1,
     token = 05b04ffa2a764979b768a4b99ef010d9,
     userNike = 黄河,
     userSmallImg = <null>,
     userBigWidth = <null>,
     recommoned = <null>,
     userRole = [
     {
     updateDate = <null>,
     eredarName = 萌宝用户,
     createDate = <null>,
     updateUserId = <null>,
     eredarCode = 0,
     createUserId = <null>
     }
     ],
     userAddress = <null>,
     shutupTime = <null>,
     loginAccount = 15821565760,
     isBanned = 0
     },
     msg = 登录成功
     },
     */
}
/**登陆*/
+(void)loadLogin:(ZZLoginParam *)loginParam success:(void (^)(ZZLoginUser *loginUser ,ZZNetDataType netDataType))success failure:(errorBlock)failure{
    
    loginParam.device = @(DeviceType);
    loginParam.deviceVersion = [ZZAppSystem  appVersion];
    loginParam.model  = [ZZAppSystem appPlatform];
    loginParam.imei = [ZZAppSystem  appUDID];
    loginParam.applicationVersion = [ZZAppSystem  appVersion];
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/login";
    param.parameters = [loginParam keyValues];
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        ZZLoginUser *user = [ZZLoginUser  objectWithKeyValues:json];
        success(user,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType  netDataType) {
        
        failure(error,netDataType);
    }];
}
/**获取注册验证码*/
+ (void)loadGetResignCode:(NSString *)loginAccount success:(successBlock)success  failure:(errorBlock)failure{
    
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/getRegisterSecurityCode";
    param.parameters = @{@"loginAccount":loginAccount};
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        
        success(json,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType  netDataType) {
        
        failure(error,netDataType);
    }];
    /*
     response = {
     status = 1,
     msg = 发送成功
     }
     */
}
/**下一步，验证验证码*/
+(void)loadVerifyCode:(NSString *)loginAccount code:(NSString *)securityCode success:(successBlock)success failure:(errorBlock)failure{
    
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/registerNext";
    param.parameters = @{@"loginAccount":loginAccount,@"securityCode":securityCode};
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        
        success(json,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType  netDataType) {
        
        failure(error,netDataType);
    }];
    /*
    response = {
        status = 1,
        msg = 手机号与验证码正确
    }
     */
}
/**忘记密码*/
+ (void)loadForgetPWD:(NSString *)loginAccount  word:(NSString *)loginPassword success:(void (^)(ZZLoginUser *loginUser ,ZZNetDataType netDataType))success  failure:(errorBlock)failure{
    
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/forgetPWD";
    param.parameters = @{@"loginAccount":loginAccount,@"loginPassword":loginPassword};
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
       
        ZZLoginUser *user = [ZZLoginUser  objectWithKeyValues:json];
        success(user,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType  netDataType) {
        
        failure(error,netDataType);
    }];
}
/**获取验证码*/
+ (void)loadGetCode:(NSString *)loginAccount success:(successBlock)success  failure:(errorBlock)failure{
    
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/getSecurityCode";
    param.parameters = @{@"loginAccount":loginAccount};
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        
        success(json,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType  netDataType) {
        
        failure(error,netDataType);
    }];
}


@end
