//
//  ZZUMLoginModel.h
//  TalentService
//
//  Created by zhizhen on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    ZZUMLoginTypeQQ ,//qq登陆
    ZZUMLoginTypeSina,//新浪登陆
    ZZUMLoginTypeWeChat//微信登陆
    
}ZZUMLoginType;
@interface ZZUMLoginModel : NSObject
@property (nonatomic, copy) NSString*  imageName;
@property (nonatomic, copy) NSString*  name;
@property (nonatomic, copy) NSString*  shareType;
@property (nonatomic) ZZUMLoginType  loginType;

- (instancetype)initWithImageName:(NSString *)imageName
                        shareType:(NSString *)shareType
                        loginType:(ZZUMLoginType )loginType
                             name:(NSString *)name;
@end
