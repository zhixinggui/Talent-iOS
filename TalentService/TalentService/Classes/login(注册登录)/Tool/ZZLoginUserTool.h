//
//  ZZLoginUserTool.h
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "ZZLoginUser.h"
#define ZZLoginTool [ZZLoginUserTool  sharedZZLoginUserTool]
@interface ZZLoginUserTool : NSObject
singleton_interface(ZZLoginUserTool);
@property (nonatomic, strong, readonly)ZZLoginUser *loginUser;
/**  存储帐号 */
- (void)save:(ZZLoginUser *)loginUser;
/**是否登陆*/
- (BOOL)islogin;
/**登陆的token*/
- (NSString *)loginToken;


@end
