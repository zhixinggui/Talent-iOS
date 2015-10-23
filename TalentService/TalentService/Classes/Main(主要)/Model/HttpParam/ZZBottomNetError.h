//
//  ZZBottomNetError.h
//  TalentService
//
//  Created by zhizhen on 15/10/23.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
//UMSResponseCodeSuccess            = 200,        //成功
//UMSREsponseCodeTokenInvalid       = 400,        //授权用户token错误
//UMSResponseCodeBaned              = 505,        //用户被封禁
//UMSResponseCodeFaild              = 510,        //发送失败（由于内容不符合要求或者其他原因）
//UMSResponseCodeArgumentsError     = 522,        //参数错误,提供的参数不符合要求
//UMSResponseCodeEmptyContent       = 5007,       //发送内容为空
//UMSResponseCodeShareRepeated      = 5016,       //分享内容重复
//UMSResponseCodeGetNoUidFromOauth  = 5020,       //授权之后没有得到用户uid
//UMSResponseCodeAccessTokenExpired = 5027,       //token过期
//UMSResponseCodeNetworkError       = 5050,       //网络错误
//UMSResponseCodeGetProfileFailed   = 5051,       //获取账户失败
//UMSResponseCodeCancel             = 5052,        //用户取消授权
//UMSResponseCodeNotLogin           = 5053,       //用户没有登录
//UMSResponseCodeNoApiAuthority     = 100031      //QQ空间应用没有在QQ互联平台上申请上传图片到相册的权限
typedef enum {
    /**请求的路径不存在*/
    ZZBottomErrorCodeRequestUrlNoExit = 1 ,
    /**API内部错误信息*/
    ZZBottomErrorCodeAPIError = 2 ,
    /**参数不完整*/
    ZZBottomErrorCodeArgumentsError = 3 ,
    
    /**用户不存在*/
    ZZBottomErrorCodeUserNoExit = 11 ,
    /**密码错误*/
    ZZBottomErrorCodePWDError = 12 ,
    /**账号未开通，请联系客服*/
    ZZBottomErrorCodeNoUserConnectService  = 13 ,
    /**请登录*/
    ZZBottomErrorCodeNoLogin =14 ,
    /**无效TOKEN*/
    ZZBottomErrorCodeTokenInvalid  = 15 ,
    /**无权限*/
    ZZBottomErrorCodeWithoutPermission  = 16 ,
    /**手机号不符合规则*/
    ZZBottomErrorCodePhoneWithoutRule = 17 ,
    /**验证码不正确*/
    ZZBottomErrorCodeVerificationCodeNotCorrect  = 18 ,
    /**验证码已过期，请重新获取（时间已过）*/
    ZZBottomErrorCodeVerificationCodeExpired = 181 ,
    /**验证码已失效，请重新获取（使用过）*/
    ZZBottomErrorCodeVerificationCodeUsed = 182 ,
    /**邮件地址不正确*/
    ZZBottomErrorCodeEmailError = 19 ,
    
    /**不支持该支付方式*/
    ZZBottomErrorCodeNoSupportThePayment = 51 ,
    /**订单已过期*/
    ZZBottomErrorCodeOrderExpired = 52 ,
    
    /**重复下单*/
    ZZBottomErrorCodeRepeatOrder = 61 ,
}ZZBottomErrorCode;

@interface ZZBottomNetError : NSObject
@property (nonatomic, copy)NSString *errorInfo;
@property (nonatomic) ZZBottomErrorCode errorCode;
@end
