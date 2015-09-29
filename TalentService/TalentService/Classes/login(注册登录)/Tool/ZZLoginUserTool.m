//
//  ZZLoginUserTool.m
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//
#define ZZLoginUserFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"loginUser.data"]
#import "ZZLoginUserTool.h"
#import "ZZLoginUser.h"
@interface ZZLoginUserTool ()
@property (nonatomic, strong)ZZLoginUser *loginUser;
@end
@implementation ZZLoginUserTool
singleton_implementation(ZZLoginUserTool);
-(ZZLoginUser *)loginUser{
    if (_loginUser == nil) {
        // 读取帐号
        _loginUser = [NSKeyedUnarchiver unarchiveObjectWithFile:ZZLoginUserFilepath];
    }
    return _loginUser;
}

- (void)save:(ZZLoginUser *)loginUser
{
    // 归档
 [NSKeyedArchiver archiveRootObject:loginUser toFile:ZZLoginUserFilepath];
    self.loginUser = loginUser;
}

-(BOOL)islogin{
    return self.loginUser ? YES :NO;
}

-(NSString *)loginToken{
    return self.loginUser.token;
}

@end
