//
//  ZZLoginUser.m
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZLoginUser.h"
#import "ZZUserRole.h"
@implementation ZZLoginUser
+(NSDictionary *)objectClassInArray{
    return @{@"userRole":[ZZUserRole class ]};
}
MJCodingImplementation;
@end
