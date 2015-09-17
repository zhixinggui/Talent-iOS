//
//  ZZHomeServiceResult.m
//  TalentService
//
//  Created by zhizhen on 15/9/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZHomeServiceResult.h"
#import "ZZActivity.h"
@implementation ZZHomeServiceResult
+(NSDictionary *)objectClassInArray{
    return @{@"rows":[ZZActivity class ]};
}
@end
