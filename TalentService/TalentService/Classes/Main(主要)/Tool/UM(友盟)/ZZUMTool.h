//
//  ZZUMTool.h
//  TalentService
//
//  Created by zhizhen on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//   友盟分享工具

#import <Foundation/Foundation.h>
#import "ZZUMLoginModel.h"
/** 友盟回调block */
typedef void (^UMToolSuccCallBack)(NSString *usid ,NSString *nick, ZZLoginType loginType);
typedef void (^UMToolFailCallBack)(NSString *reason);
typedef enum {
    ZZSViewControllerTypeLoginAccount,//登陆
    ZZSViewControllerTypeLoginShare//分享
}ZZSViewControllerType;

typedef enum {
    ZZUMToolResponseSuccess,
    ZZUMToolResponseFaile
}ZZUMToolResponse;

@protocol ZZUMToolSocialDelgate <NSObject>

@optional
// 关闭当前页面之后
- (void)didCloseUIViewController:(ZZSViewControllerType)fromViewControllerType;

//各个页面执行授权完成、分享完成、或者评论完成时的回调函数
-(void)didFinishGetUMSocialDataInViewController:(ZZUMToolResponse )umToolResponse result:(NSString *)result;

@end
@interface ZZUMTool : NSObject

/**  单例 */
+(instancetype)sharedUMTool;
/** 支持的三方登陆 */
@property (nonatomic, strong, readonly)NSMutableArray* loginModels;
/** 分享支持的类型 */
@property (nonatomic, strong, readonly)NSMutableArray* shareModels;
/** 支持QQ不 */
@property (nonatomic, assign, readonly, getter=isSupportQQ)BOOL supportQQ;
/** 支持新浪不 */
@property (nonatomic, assign, readonly, getter=isSupportSina)BOOL supportSina;
/** 支持微信不 */
@property (nonatomic, assign, readonly, getter=isSupportWX)BOOL supportWX;

@property (nonatomic, weak) id<ZZUMToolSocialDelgate> delegate;

/**
 *  友盟三方登陆响应方法
 *
 *  @param controller <#controller description#>
 *  @param loginModel <#loginModel description#>
 *  @param umToolBack <#umToolBack description#>
 */
- (void)umThirdLoginWithController:(UIViewController*)controller andUmloginModel:(ZZUMLoginModel *)loginModel andSuccBack:(UMToolSuccCallBack)umToolSuccBack andFailBack:(UMToolFailCallBack)umToolFailBack;

//分享方法
- (void)umShareWithTitle:(NSString *)title  content:(NSString *)content url:(NSString *)url imageUrl:(NSString *)imageUrl locialImageName:(NSString *)imageName  controller:(UIViewController <ZZUMToolSocialDelgate> *)controller  loginModel:(ZZUMLoginModel *)loginModel;

/**
 *  退出友盟三方授权
 *
 *  @param umSdkShare 判断是哪个三方登入
 */
-(void)umThirdShareCancel;


/** 友盟社会化分享三个系统回调方法 */
+ (BOOL)umSocialHandleOpenURL:(NSURL *)url;

/** 友盟数据统计界面统计开始，在viewWillAppear中 */
+ (void)umMobClickBeginLogPageView:(NSString *)viewName;
/** 友盟数据统计界面统计结束，在viewWillDisappear中  */
+ (void)umMobClickEndLogPageView:(NSString *)viewName;
@end
