//
//  ZZJsonInfoTool.m
//  TalentService
//
//  Created by charles on 15/9/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZJsonInfoTool.h"
#import "ZZLoginUserTool.h"

@implementation ZZJsonInfoTool
/**
 *  个人信息解析
 *
 *  @param dic <#dic description#>
 */
+(void)parseSelfInfomation:(NSDictionary *)dic{
    if ([dic safeDictionary]) {
        ZZLoginUserTool *loginuserTool = [ZZLoginUserTool sharedZZLoginUserTool];
        loginuserTool.loginUser.userId = [[[dic objectForKey:@"userId"]safeString] integerValue];
        loginuserTool.loginUser.userNike = [[dic objectForKey:@"userNike"]safeString];
        if ([[dic objectForKey:@"userRole"]safeArray]) {
            NSArray *userRoles = [ZZUserRole  objectArrayWithKeyValuesArray:[dic objectForKey:@"userRole"]];
            loginuserTool.loginUser.userRole= userRoles;
        }
        
        loginuserTool.loginUser.fans = [[[dic objectForKey:@"fans"]safeString]integerValue];
        
        loginuserTool.loginUser.userPhone = [[dic objectForKey:@"userPhone"]safeString];
        
        loginuserTool.loginUser.userAddress = [[dic objectForKey:@"userAddress"]safeString];
        
        loginuserTool.loginUser.userSex = [[[dic objectForKey:@"userSex"]safeString]integerValue];
        NSNotification * noti = [NSNotification  notificationWithName:ZZUserNickChangeNoti object:nil];
        [[NSNotificationCenter  defaultCenter]postNotification:noti];

    }
}
@end
