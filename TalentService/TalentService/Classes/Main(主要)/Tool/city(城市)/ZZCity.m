//
//  ZZCity.m
//  TalentService
//
//  Created by zhizhen on 15/9/8.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZCity.h"
#import "ZZCounty.h"

@implementation ZZCity

- (NSDictionary *)objectClassInArray
{
    return @{@"counties" : [ZZCounty class]};
}
- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"cityId" : @"id"};
}
@end
