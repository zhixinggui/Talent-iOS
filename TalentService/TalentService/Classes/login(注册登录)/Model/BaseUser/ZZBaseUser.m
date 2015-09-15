//
//  ZZBaseUser.m
//  TalentService
//
//  Created by 张亮亮 on 15/9/13.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZBaseUser.h"
#import "ZZUserRole.h"
@implementation ZZBaseUser
+(NSDictionary *)objectClassInArray{
    return @{@"userRole":[ZZUserRole class ]};
}

@end

