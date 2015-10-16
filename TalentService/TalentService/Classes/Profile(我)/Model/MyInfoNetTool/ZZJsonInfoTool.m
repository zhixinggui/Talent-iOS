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
+(ZZOtherUser *)parseSelfInfomation:(NSDictionary *)dic{
    if ([dic safeDictionary]) {
        ZZOtherUser *loginUser = [[ZZOtherUser alloc]init];
        loginUser.userId = [[[dic objectForKey:@"userId"]safeString] integerValue];
        loginUser.userNike = [[dic objectForKey:@"userNike"]safeString];
        if ([[dic objectForKey:@"userRole"]safeArray]) {
            NSArray *userRoles = [ZZUserRole  objectArrayWithKeyValuesArray:[dic objectForKey:@"userRole"]];
            loginUser.userRole= userRoles;
        }
        
        loginUser.fans = [[dic objectForKey:@"fans"]integerValue];
        
        loginUser.userPhone = [[dic objectForKey:@"userPhone"]safeString];
        
        loginUser.userAddress = [[dic objectForKey:@"userAddress"]safeString];
        
        loginUser.userSex = [[[dic objectForKey:@"userSex"]safeNumber]integerValue];
        loginUser.userSmallImg = [[dic objectForKey:@"userSmallImg"]safeString];
        
        loginUser.isAttention = [[dic objectForKey:@"isAttention"]boolValue];
        
        loginUser.backgroundImg = [[dic objectForKey:@"backgroundImg"]safeString];
        
        loginUser.userId = [[dic objectForKey:@"userId"]integerValue];
        
        loginUser.isEredar = [[dic objectForKey:@"isEredar"]boolValue];
        
        loginUser.userPresentation = [[dic objectForKey:@"userPresentation"]safeString];
        return loginUser;
    }else{
        return nil;
    }
    
}

/**
 *  修改信息
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
        
        loginUser.fans = [[dic objectForKey:@"fans"]integerValue];
        
        loginUser.userPhone = [[dic objectForKey:@"userPhone"]safeString];
        
        loginUser.userAddress = [[dic objectForKey:@"userAddress"]safeString];
        
        loginUser.userSex = [[[dic objectForKey:@"userSex"]safeNumber]integerValue];
        loginUser.userSmallImg = [[dic objectForKey:@"userSmallImg"]safeString];
        
        loginUser.backgroundImg = [[dic objectForKey:@"backgroundImg"]safeString];
        
//        loginUser.city = [[dic objectForKey:@"city"]integerValue];
//        
//        loginUser.province = [[dic objectForKey:@"province"]integerValue];
//        
//        loginUser.district = [[dic objectForKey:@"district"]integerValue];
        
        loginUser.userPresentation = [[dic objectForKey:@"userPresentation"]safeString];
        NSNotification * noti = [NSNotification  notificationWithName:ZZUserNickChangeNoti object:nil];
        [[NSNotificationCenter  defaultCenter]postNotification:noti];
        [[ZZLoginUserTool sharedZZLoginUserTool] save:loginUser];
    }
}




@end
