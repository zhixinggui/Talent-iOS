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
@property (nonatomic, copy)NSString *sinaShareText;
@property (nonatomic, weak)UIViewController *controller;
@property (nonatomic, strong)NSData *imageData;

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content  url:(NSString *)url imageUrl:(NSString *)imageUrl  imageName:(NSString *)imageName controller:(UIViewController *)controller;
@end
//分享字数限制
NSUInteger const   ShareTitleLength = 64;
NSUInteger const   ShareContentLength = 128;
NSString * const DefaultImageName = @"icon.png"; //没有图片时默认分享的图片名字
//友盟分享
NSString * const UMSocialAppKey = @"560131d3e0f55a5dc1001859";
//友盟数据统计
NSString * const UMMobClickAppKey = @"560131d3e0f55a5dc1001859";//

//QQ
NSString * const QQAppId = @"1104000906";//
NSString * const QQAppKey = @"T73NH4Tz75dWsPdy";//
NSString * const QQurl = @"http://www.umeng.com/social";//

//微信
NSString * const WXAppId = @"wx766b807ef51aa8da";//
NSString * const WXAppSecret = @"139fc6ccddba72262d94688368082312";//
NSString * const WXurl = @"http://www.umeng.com/social";//

//新浪
//NSString * const SinaAppId = @"2019049338";//
//NSString * const SinaAppKey = @"96ae214825838c1fd26d9637ab39460d";//
NSString * const SinaUrl = @"https://api.weibo.com/oauth2/default.html";//
@interface ZZUMTool ()<UMSocialUIDelegate>
/** 支持的三方登陆 */
@property (nonatomic, strong)NSMutableArray* loginModels;
/** 分享支持的类型 */
@property (nonatomic, strong)NSMutableArray* shareModels;
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
    [super initialize];
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
static ZZUMTool *umTool;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        umTool = [super allocWithZone:zone];
        [umTool  umToolInit];
    });
    
    return umTool;
}

+ (instancetype)sharedUMTool
{
    if (umTool == nil) {
        umTool = [[self alloc] init];
    }
    
    return umTool;
}


/** 初始化分享数组 */

-(void)umToolInit{
    self.loginModels = [NSMutableArray  array];
    self.shareTypes = [NSMutableArray  array];
    self.shareModels = [NSMutableArray  array];
    
    
    // 微信分享入口
    if ([WXApi isWXAppSupportApi]){//是否有微信客户端
        [UMSocialWechatHandler setWXAppId:WXAppId appSecret:WXAppSecret url:WXurl];
        
        
        //创建微信登陆模型
        ZZUMLoginModel *wxLoginModel = [[ZZUMLoginModel alloc]initWithImageName:@"wechat_60x60" shareType:UMShareToWechatSession loginType:ZZUMLoginTypeWeChatFriend name:@"微信"];
        [self.loginModels addObject:wxLoginModel];
        //创建微信好友分享模型
        ZZUMLoginModel *friendShareModel = [[ZZUMLoginModel alloc]initWithImageName:@"wechat_share_60x60" shareType:UMShareToWechatSession loginType:ZZUMLoginTypeWeChatFriend name:@"微信好友"];
        [self.shareModels addObject:friendShareModel];
        [self.shareTypes addObject:UMShareToWechatSession];
        //创建微信朋友圈分享模型
        ZZUMLoginModel *friendsShareModel = [[ZZUMLoginModel alloc]initWithImageName:@"wechatfriends_share_60x60" shareType:UMShareToWechatTimeline loginType:ZZUMLoginTypeWeChatFriends name:@"朋友圈"];
        [self.shareModels addObject:friendsShareModel];
        [self.shareTypes addObject:UMShareToWechatTimeline];
        self.supportWX = YES;
    }
    
    
     //   QQ分享入口
    if ([TencentOAuth iphoneQQSupportSSOLogin]) {//是否安装有QQ客户端
        [UMSocialQQHandler setQQWithAppId:QQAppId appKey:QQAppKey url:QQurl];
        //创建qq登陆模型
        ZZUMLoginModel *qqLoginModel = [[ZZUMLoginModel alloc]initWithImageName:@"QQ_60x60" shareType:UMShareToQQ loginType:ZZUMLoginTypeQQ name:@"QQ"];
        [self.loginModels addObject:qqLoginModel];
        //qq分享模型
        ZZUMLoginModel *qqshareModel = [[ZZUMLoginModel alloc]initWithImageName:@"QQ_share_60x60" shareType:UMShareToQQ loginType:ZZUMLoginTypeQQ name:@"QQ"];
        [self.shareModels addObject:qqshareModel];
        [self.shareTypes addObject:UMShareToQQ];
        
        //qq空间分享模型
       ZZUMLoginModel *zoneShareModel = [[ZZUMLoginModel alloc]initWithImageName:@"Qzong_share_60x60" shareType:UMShareToQzone loginType:ZZUMLoginTypeQQZone name:@"QQ空间"];
        [self.shareModels  addObject:zoneShareModel];
        [self.shareTypes addObject:UMShareToQzone];
        self.supportQQ = YES;
    }
    
     // 新浪分享入口
    [UMSocialSinaSSOHandler  openNewSinaSSOWithRedirectURL:SinaUrl];
    
    //创建新浪登陆模型
    ZZUMLoginModel *sinaLoginModel = [[ZZUMLoginModel alloc]initWithImageName:@"weibo_60x60" shareType:UMShareToSina loginType:ZZUMLoginTypeSina name:@"新浪"];
    [self.loginModels addObject:sinaLoginModel];
    //创建新浪分享模型
    ZZUMLoginModel *sinaShareModel = [[ZZUMLoginModel alloc]initWithImageName:@"weibo_share_60x60" shareType:UMShareToSina loginType:ZZUMLoginTypeSina name:@"新浪"];
    [self.shareModels addObject:sinaShareModel];
    [self.shareTypes addObject:UMShareToSina];
    self.supportSina = YES;
}
//设置分享链接
- (void)setShareDefaultData:(ZZShareModel *)shareModel{
    if ( self.supportWX) {
        /**  微信设置要分享的链接和title*/
        //微信好友
        [UMSocialData defaultData].extConfig.wechatSessionData.url = shareModel.url;
        [UMSocialData defaultData].extConfig.wechatSessionData.title = shareModel.title;
        //微信朋友圈
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareModel.url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = shareModel.title;
    }
    if (self.supportQQ) {
        /** QQ设置要分享的链接*/
        //qq
        [UMSocialData defaultData].extConfig.qqData.url = shareModel.url;
        [UMSocialData defaultData].extConfig.qqData.title = shareModel.title;
        //qq空间
        [UMSocialData defaultData].extConfig.qzoneData.url = shareModel.url;
        [UMSocialData defaultData].extConfig.qzoneData.title = shareModel.title;
    }
    
    
}
//根据错误代码得到错误信息
- (NSString *)getShareInfoWtihResponseCode:(UMSResponseCode )responseCode{
    switch (responseCode) {
        case UMSResponseCodeSuccess:
            return @"分享成功";
        case UMSREsponseCodeTokenInvalid:
            return @"授权用户token错误";
        case UMSResponseCodeBaned:
            return @"用户被封禁";
        case UMSResponseCodeFaild:
            return @"内容不符合要求或者其他原因";
        case UMSResponseCodeArgumentsError:
            return @"参数错误";
        case UMSResponseCodeEmptyContent:
            return @"发送内容为空";
        case UMSResponseCodeShareRepeated:
            return @"分享内容重复";
        case UMSResponseCodeGetNoUidFromOauth:
            return @"授权失败";
        case UMSResponseCodeAccessTokenExpired:
            return @"token过期";
        case UMSResponseCodeNetworkError:
            return @"网络错误";
        case UMSResponseCodeGetProfileFailed:
            return @"获取账户失败";
        case UMSResponseCodeCancel:
            return @"用户取消授权";
        case UMSResponseCodeNotLogin:
            return @"用户没有登录";
        case UMSResponseCodeNoApiAuthority:
            return @"没有响应权限";
        default:
            return @"分享失败";
    }

}
//得到系统的登陆类型
- (ZZLoginType )getSystemLoginTypeWithSelfType:(ZZUMLoginType ) umType{
    switch (umType) {
        case ZZUMLoginTypeQQ:
        ZZUMLoginTypeQQZone:
            return ZZLoginTypeQQ;
        case ZZUMLoginTypeWeChatFriend:
        ZZUMLoginTypeWeChatFriends:
            return ZZLoginTypeWeChat;
        case ZZUMLoginTypeSina:
            return ZZLoginTypeSina;
            
        default:
            return ZZLoginTypeQQ;
    }
}
#pragma mark - private methods

/**
 *  友盟三方登陆响应方法
 */
- (void)umThirdLoginWithController:(UIViewController*)controller andUmloginModel:(ZZUMLoginModel *)loginModel andSuccBack:(UMToolSuccCallBack)umToolSuccBack andFailBack:(UMToolFailCallBack)umToolFailBack{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:loginModel.shareType];
     [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    snsPlatform.loginClickHandler(controller,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:loginModel.shareType];
            if (snsAccount.usid.length && snsAccount.userName.length) {
                umToolSuccBack(snsAccount.usid, snsAccount.userName, [self  getSystemLoginTypeWithSelfType:loginModel.loginType] );
            }else{
                umToolFailBack(@"参数错误");
            }
#warning 未完待续
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }else{
            umToolFailBack([self  getShareInfoWtihResponseCode:response.responseCode]);
        }
    });
}

- (void)umShareWithTitle:(NSString *)title  content:(NSString *)content url:(NSString *)url imageUrl:(NSString *)imageUrl locialImageName:(NSString *)imageName  controller:(UIViewController <ZZUMToolSocialDelgate> *)controller  loginModel:(ZZUMLoginModel *)loginModel{
    
    ZZShareModel *shareModel = [[ZZShareModel  alloc]initWithTitle:title content:content url:url imageUrl:imageUrl imageName:imageName controller:controller];
    self.shareModel = shareModel;
    self.delegate = controller;
    [self  setShareDefaultData:shareModel];
    
    if (loginModel) {//自定义的ui界面
        
        if (loginModel.loginType == ZZUMLoginTypeSina) {//新浪
            
            [[UMSocialControllerService defaultControllerService] setShareText:self.shareModel.sinaShareText shareImage:self.shareModel.imageData socialUIDelegate:self];        //设置分享内容和回调对象
           [UMSocialSnsPlatformManager getSocialPlatformWithName:loginModel.shareType].snsClickHandler(self.shareModel.controller,[UMSocialControllerService defaultControllerService],YES); 
        }else{//QQ、微信
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[loginModel.shareType] content:self.shareModel.content image:self.shareModel.imageData location:nil urlResource:nil presentedController:self.shareModel.controller completion:^(UMSocialResponseEntity *response){
                [self  didFinishGetUMSocialDataInViewController:response];
            }];
        }
        
    }else{//默认分享
        [UMSocialSnsService presentSnsIconSheetView:self.shareModel.controller
                                             appKey:UMSocialAppKey
                                          shareText:self.shareModel.content
                                         shareImage:self.shareModel.imageData
                                    shareToSnsNames:self.shareTypes
                                           delegate:self];
    }

}


/**
 *  退出三方登入
 *
 *  @param umSdkShare <#umSdkShare description#>
 */
-(void)umThirdShareCancel{
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
        
    }];
    
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        
    }];
    
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
        
    }];
}
#pragma mark - UMSocialUIDelegate
///**
// 自定义关闭授权页面事件
// @param navigationCtroller 关闭当前页面的navigationCtroller对象
// */
//-(BOOL)closeOauthWebViewController:(UINavigationController *)navigationCtroller socialControllerService:(UMSocialControllerService *)socialControllerService{
//    return YES;
//}

/**
 关闭当前页面之后
 */
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType{
    if ([self.delegate  respondsToSelector:@selector(didCloseUIViewController:)]) {
        ZZSViewControllerType ctype ;
        if(fromViewControllerType == UMSViewControllerLogin){
            ctype = ZZSViewControllerTypeLoginAccount;
        }else{
            ctype = ZZSViewControllerTypeLoginShare;
        }
            
        [self.delegate  didCloseUIViewController:ctype];
    }
}

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
     [UMSocialConfig setFinishToastIsHidden:YES position:UMSocialiToastPositionCenter];
    if ([self.delegate  respondsToSelector:@selector(didFinishGetUMSocialDataInViewController:result:)]) {
        if(response.responseCode == UMSResponseCodeSuccess){
        [self.delegate  didFinishGetUMSocialDataInViewController:ZZUMToolResponseSuccess result:[self  getShareInfoWtihResponseCode:response.responseCode]];
        }else{
          [self.delegate  didFinishGetUMSocialDataInViewController:ZZUMToolResponseFaile result:[self  getShareInfoWtihResponseCode:response.responseCode]];
        }
    }
}

/**
 点击分享列表页面，之后的回调方法，你可以通过判断不同的分享平台，来设置分享内容。
 例如：
 */
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    if ([platformName  isEqualToString:@"sina"]) {
        socialData.shareText = self.shareModel.sinaShareText;
    }
  
}


///**
// 配置点击分享列表后是否弹出分享内容编辑页面，再弹出分享，默认需要弹出分享编辑页面
// */
//-(BOOL)isDirectShareInIconActionSheet{
//    return YES;
//}

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
-(NSString *)sinaShareText{
    if (_sinaShareText == nil) {
        NSMutableString *shareMstr = [NSMutableString  string];
        if (self.title) {
            [shareMstr  appendString:self.title];
        }else{
            if (self.content ) {
                [shareMstr  appendString:self.content];
            }else{
                [shareMstr appendString:@"来自萌宝派"];
            }
        }
        if(self.url){
            [shareMstr appendString:@","];
            [shareMstr appendString:self.url];
        }
        _sinaShareText = [shareMstr  copy];
    }
    return _sinaShareText;
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
