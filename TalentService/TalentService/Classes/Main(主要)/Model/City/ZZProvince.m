//
//  ZZProvince.m
//  TalentService
//
//  Created by zhizhen on 15/9/8.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZProvince.h"

#import "ZZCity.h"
@implementation ZZProvince
+ (NSDictionary *)objectClassInArray
{
    return @{@"cities" : [ZZCity class]};
}
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"provinceId" : @"id"};
}

@end
