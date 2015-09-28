//
//  ZZActivityListResult.m
//  TalentService
//
//  Created by zhizhen on 15/9/28.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityListResult.h"
#import "ZZActivity.h"
@implementation ZZActivityListResult
+(NSDictionary *)objectClassInArray{
    return @{@"rows":[ZZActivity class ]};
}
@end
