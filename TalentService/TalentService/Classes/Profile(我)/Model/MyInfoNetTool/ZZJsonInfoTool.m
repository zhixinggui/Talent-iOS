//
//  ZZJsonInfoTool.m
//  TalentService
//
//  Created by charles on 15/9/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZJsonInfoTool.h"
#import "ZZLoginUserTool.h"
#import "ZZOtherUser.h"
@implementation ZZJsonInfoTool
/**
 *  个人信息解析
 *
 *  @param dic <#dic description#>
 */
+(ZZLoginUser *)parseSelfInfomation:(NSDictionary *)dic{
    if ([dic safeDictionary]) {
        ZZLoginUser *loginUser = [ZZLoginUserTool sharedZZLoginUserTool].loginUser;
        loginUser.userId = [[[dic objectForKey:@"userId"]safeString] integerValue];
        loginUser.userNike = [[dic objectForKey:@"userNike"]safeString];
        if ([[dic objectForKey:@"userRole"]safeArray]) {
            NSArray *userRoles = [ZZUserRole  objectArrayWithKeyValuesArray:[dic objectForKey:@"userRole"]];
            loginUser.userRole= userRoles;
        }
        
        loginUser.fans = [[[dic objectForKey:@"fans"]safeString]integerValue];
        
        loginUser.userPhone = [[dic objectForKey:@"userPhone"]safeString];
        
        loginUser.userAddress = [[dic objectForKey:@"userAddress"]safeString];
        
        loginUser.userSex = [[[dic objectForKey:@"userSex"]safeNumber]integerValue];
        loginUser.userBigImg = [[dic objectForKey:@"userBigImg"]safeString];
        loginUser.isAttention = [[dic objectForKey:@"isAttention"]boolValue];
        return loginUser;
    }else{
        return nil;
    }
    
}

/**
 *  修改名字
 */
+(void)parseChangeInformation:(NSDictionary *)dic{
    if ([dic safeDictionary]) {
        ZZLoginUser *loginUser = [ZZLoginUserTool sharedZZLoginUserTool].loginUser;
        loginUser.userId = [[[dic objectForKey:@"userId"]safeString] integerValue];
        loginUser.userNike = [[dic objectForKey:@"userNike"]safeString];
        if ([[dic objectForKey:@"userRole"]safeArray]) {
            NSArray *userRoles = [ZZUserRole  objectArrayWithKeyValuesArray:[dic objectForKey:@"userRole"]];
            loginUser.userRole= userRoles;
        }
        
        loginUser.fans = [[[dic objectForKey:@"fans"]safeString]integerValue];
        
        loginUser.userPhone = [[dic objectForKey:@"userPhone"]safeString];
        
        loginUser.userAddress = [[dic objectForKey:@"userAddress"]safeString];
        
        loginUser.userSex = [[[dic objectForKey:@"userSex"]safeNumber]integerValue];
        NSNotification * noti = [NSNotification  notificationWithName:ZZUserNickChangeNoti object:nil];
        [[NSNotificationCenter  defaultCenter]postNotification:noti];
    }
}




@end
