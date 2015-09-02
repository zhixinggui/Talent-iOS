//
//  ZZUMLoginModel.h
//  TalentService
//
//  Created by zhizhen on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZFunctionShowRule.h"
typedef enum {
    
    ZZUMLoginTypeQQ ,//qq登、分享
    ZZUMLoginTypeSina,//新浪登陆、分享
    ZZUMLoginTypeWeChatFriend,//微信登陆、好友分享
    ZZUMLoginTypeQQZone,//qq空间分享
    ZZUMLoginTypeWeChatFriends,//微信朋友圈分享
    
}ZZUMLoginType;
@interface ZZUMLoginModel : NSObject <ZZFunctionShowRuleDelegate>
@property (nonatomic, copy) NSString*  imageName;
@property (nonatomic, copy) NSString*  name;
@property (nonatomic, copy) NSString*  shareType;
@property (nonatomic) ZZUMLoginType  loginType;

- (instancetype)initWithImageName:(NSString *)imageName
                        shareType:(NSString *)shareType
                        loginType:(ZZUMLoginType )loginType
                             name:(NSString *)name;
@end
