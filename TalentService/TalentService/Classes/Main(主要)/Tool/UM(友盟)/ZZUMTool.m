//
//  ZZUMTool.m
//  TalentService
//
//  Created by zhizhen on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZUMTool.h"

#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "WXApi.h"
#import "MobClick.h"
#import "UMSocial.h"
#import "SDImageCache.h"

@interface ZZShareModel : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *imageUrl;
@property (nonatomic, copy)NSString *imageName;
@property (nonatomic, weak)UIViewController *controller;
@property (nonatomic, strong)NSData *imageData;

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content  url:(NSString *)url imageUrl:(NSString *)imageUrl  imageName:(NSString *)imageName controller:(UIViewController *)controller;
@end
//分享字数限制
NSUInteger const   ShareTitleLength = 64;
NSUInteger const   ShareContentLength = 128;
NSString * const DefaultImageName = @"icon.png"; //没有图片时默认分享的图片名字
//友盟分享
NSString * const UMSocialAppKey = @"556e722967e58e98be002ba7";
//友盟数据统计
NSString * const UMMobClickAppKey = @"556e722967e58e98be002ba7";//

//QQ
NSString * const QQAppId = @"1104000906";//
NSString * const QQAppKey = @"T73NH4Tz75dWsPdy";//
NSString * const QQurl = @"http://www.umeng.com/social";//

//微信
NSString * const WXAppId = @"wx766b807ef51aa8da";//
NSString * const WXAppSecret = @"139fc6ccddba72262d94688368082312";//
NSString * const WXurl = @"http://www.umeng.com/social";//

//新浪
//NSString * const SinaAppId = @"1104000906";//
//NSString * const SinaAppKey = @"T73NH4Tz75dWsPdy";//
NSString * const sinaurl = @"https://api.weibo.com/oauth2/default.html";//
@interface ZZUMTool ()<UMSocialUIDelegate>
/** 支持的三方登陆 */
@property (nonatomic, strong)NSMutableArray* loginModels;
/** 分享支持的类型 */
@property (nonatomic, strong)NSMutableArray* shareTypes;
/** 支持QQ不 */
@property (nonatomic, assign, getter=isSupportQQ)BOOL supportQQ;
/** 支持新浪不 */
@property (nonatomic, assign,  getter=isSupportSina)BOOL supportSina;
/** 支持微信不 */
@property (nonatomic, assign, getter=isSupportWX)BOOL supportWX;

@property (nonatomic, strong) ZZShareModel *shareModel;

@end
@implementation ZZUMTool
#pragma mark  -init
/** 应用启动就设置*/
+(void)initialize{
    //设置友盟分享sdkappkey
    [UMSocialData setAppKey:UMSocialAppKey];
    
    //使用友盟统计
    [MobClick startWithAppkey:UMMobClickAppKey reportPolicy:BATCH   channelId:nil];
    /** 设置是否对日志信息进行加密, 默认NO(不加密). */
   // [MobClick  setEncryptEnabled:YES];
    /** 设置是否开启background模式, 默认YES. */
   // [MobClick  setBackgroundTaskEnabled:NO];

}

/** 实现单例的类方法*/
singleton_implementation(ZZUMTool);

-(NSMutableArray *)loginModels{
    if (_loginModels == nil) {
        [self  umToolInit];
    }
    return _loginModels;
}

-(NSMutableArray *)shareTypes{
    if (_shareTypes == nil) {
        [self  umToolInit];
    }
    return _shareTypes;
}

/** 初始化分享数组 */

-(void)umToolInit{
    self.loginModels = [NSMutableArray  array];
    self.shareTypes = [NSMutableArray  array];
    
     //   QQ分享入口
    if ([TencentOAuth iphoneQQSupportSSOLogin]) {//是否安装有QQ客户端
        [UMSocialQQHandler setQQWithAppId:@"1104000906" appKey:@"T73NH4Tz75dWsPdy" url:@"http://www.umeng.com/social"];
        [self.shareTypes addObject:UMShareToQQ];
        [self.shareTypes addObject:UMShareToQzone];
        //创建qq登陆模型
        ZZUMLoginModel *qqLoginModel = [[ZZUMLoginModel alloc]initWithImageName:@"QQ_50x50" shareType:UMShareToQQ loginType:ZZUMLoginTypeQQ name:@"QQ"];
        [self.loginModels addObject:qqLoginModel];
        
        self.supportQQ = YES;
    }
    
     // 微信分享入口
    if ([WXApi isWXAppSupportApi]){//是否有微信客户端
        [UMSocialWechatHandler setWXAppId:@"wx766b807ef51aa8da" appSecret:@"139fc6ccddba72262d94688368082312" url:nil];
        [self.shareTypes addObject:UMShareToWechatSession];
        [self.shareTypes addObject:UMShareToWechatTimeline];
        //创建微信登陆模型
        ZZUMLoginModel *wxLoginModel = [[ZZUMLoginModel alloc]initWithImageName:@"Wechat_50x50" shareType:UMShareToWechatSession loginType:ZZUMLoginTypeWeChat name:@"微信好友"];
        [self.loginModels addObject:wxLoginModel];
        
        self.supportWX = YES;
    }
    
     // 新浪分享入口
    [UMSocialSinaSSOHandler  openNewSinaSSOWithRedirectURL:@"https://api.weibo.com/oauth2/default.html"];
    [self.shareTypes addObject:UMShareToSina];
    //创建新浪登陆模型
    ZZUMLoginModel *wxLoginModel = [[ZZUMLoginModel alloc]initWithImageName:@"weibo_50x50" shareType:UMShareToSina loginType:ZZUMLoginTypeSina name:@"新浪"];
    [self.loginModels addObject:wxLoginModel];

    self.supportSina = YES;
}

- (void)setShareDefaultData:(ZZShareModel *)shareModel{
    if (self.shareTypes && self.supportWX) {
        /**  微信设置要分享的链接和title*/
        //微信好友
        [UMSocialData defaultData].extConfig.wechatSessionData.url = shareModel.url;
        [UMSocialData defaultData].extConfig.wechatSessionData.title = shareModel.title;
        //微信朋友圈
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareModel.url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = shareModel.title;
    }
    if (self.shareTypes && self.supportQQ) {
        /** QQ设置要分享的链接*/
        //qq
        [UMSocialData defaultData].extConfig.qqData.url = shareModel.url;
        [UMSocialData defaultData].extConfig.qqData.title = shareModel.title;
        //qq空间
        [UMSocialData defaultData].extConfig.qzoneData.url = shareModel.url;
        [UMSocialData defaultData].extConfig.qzoneData.title = shareModel.title;
    }
    
    
}
#pragma mark - private methods

/**
 *  友盟三方登陆响应方法
 */
- (void)umThirdLoginWithController:(UIViewController*)controller andUmloginModel:(ZZUMLoginModel *)loginModel andBack:(UMToolCallBack)umToolBack{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:loginModel.shareType];
     [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    snsPlatform.loginClickHandler(controller,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:loginModel.shareType];
#warning 未完待续
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}

- (void)umShareWithTitle:(NSString *)title  content:(NSString *)content url:(NSString *)url imageUrl:(NSString *)imageUrl locialImageName:(NSString *)imageName  controller:(UIViewController *)controller  loginModel:(ZZUMLoginModel *)loginModel{
    
    ZZShareModel *shareModel = [[ZZShareModel  alloc]initWithTitle:title content:content url:url imageUrl:imageUrl imageName:imageName controller:controller];
    self.shareModel = shareModel;
    [self  setShareDefaultData:shareModel];
    if (loginModel) {//自定义的ui界面
            [[UMSocialControllerService defaultControllerService] setShareText:self.shareModel.content shareImage:self.shareModel.imageData socialUIDelegate:self];        //设置分享内容和回调对象
           [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self.shareModel.controller,[UMSocialControllerService defaultControllerService],YES);
    }else{
        [UMSocialSnsService presentSnsIconSheetView:self.shareModel.controller
                                             appKey:UMSocialAppKey
                                          shareText:self.shareModel.content
                                         shareImage:self.shareModel.imageData
                                    shareToSnsNames:self.shareTypes
                                           delegate:self];
    }

}



#pragma mark - UMSocialUIDelegate
/**
 自定义关闭授权页面事件
 @param navigationCtroller 关闭当前页面的navigationCtroller对象
 */
-(BOOL)closeOauthWebViewController:(UINavigationController *)navigationCtroller socialControllerService:(UMSocialControllerService *)socialControllerService{
    return NO;
}

/**
 关闭当前页面之后
 */
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType{
    if ([self.delegate  respondsToSelector:@selector(didCloseUIViewController:)]) {
        [self.delegate  didCloseUIViewController:ZZSViewControllerTypeLoginShare];
    }
}

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    if ([self.delegate  respondsToSelector:@selector(didFinishGetUMSocialDataInViewController:)]) {
        if(response.responseCode == UMSResponseCodeSuccess){
        [self.delegate  didFinishGetUMSocialDataInViewController:ZZUMToolResponseSuccess];
        }else{
          [self.delegate  didFinishGetUMSocialDataInViewController:ZZUMToolResponseFaile];
        }
    }
}

/**
 点击分享列表页面，之后的回调方法，你可以通过判断不同的分享平台，来设置分享内容。
 例如：
 */
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    if ([platformName  isEqualToString:@"sina"]) {
        socialData.shareText = [NSString  stringWithFormat:@"%@,%@",self.shareModel.title,self.shareModel.url];
    }
    if ([self.delegate  respondsToSelector:@selector(didSelectSocialPlatform:)]) {
        [self.delegate  didSelectSocialPlatform:ZZUMToolShareTypeQQ];
    }
}


/**
 配置点击分享列表后是否弹出分享内容编辑页面，再弹出分享，默认需要弹出分享编辑页面
 */
-(BOOL)isDirectShareInIconActionSheet{
    return YES;
}

#pragma mark -工厂方法
/** 友盟社会化分享三个系统回调方法 */
+ (BOOL)umSocialHandleOpenURL:(NSURL *)url{
    return  [UMSocialSnsService handleOpenURL:url];
}

/** 友盟数据统计界面统计开始，在viewWillAppear中 */
+ (void)umMobClickBeginLogPageView:(NSString *)viewName{
    [MobClick beginLogPageView:viewName];
}
/** 友盟数据统计界面统计结束，在viewWillDisappear中  */
+ (void)umMobClickEndLogPageView:(NSString *)viewName{
    [MobClick endLogPageView:viewName];
}
@end



@implementation ZZShareModel
-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content  url:(NSString *)url imageUrl:(NSString *)imageUrl  imageName:(NSString *)imageName controller:(UIViewController *)controller{
    self = [super  init];
    if (self) {
        self.title = title;
        self.content  = content;
        self.url = url;
        self.imageUrl = imageUrl;
        self.imageName = imageName;
        self.controller = controller;
    }
    return self;
}
-(void)setTitle:(NSString *)title{
    title =[title  subStringFromTitleOrcontentWithLength:ShareTitleLength];
    _title = title;
}

-(void)setContent:(NSString *)content{
    content = [content  subStringFromTitleOrcontentWithLength:ShareContentLength];
    _content = content;
}
-(NSData *)imageData{
    NSString *imagePath = self.imageUrl;
    
    UIImage *image = nil;
    NSData* imageData = nil;
    
    if (imagePath.length) {
        image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:imagePath];
        if (!image) {
            image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imagePath];
        }
        
    }
    if (image == nil) {
        if (self.imageName.length) {
            image = [UIImage  imageWithContentsOfFile:[[NSBundle  mainBundle]pathForResource:self.imageName ofType:nil]];
        }else{
            image = [UIImage  imageWithContentsOfFile:[[NSBundle  mainBundle]pathForResource:DefaultImageName ofType:nil]];
        }
    }
    imageData = UIImageJPEGRepresentation(image, 0.5);
    
    return imageData;
}
@end
