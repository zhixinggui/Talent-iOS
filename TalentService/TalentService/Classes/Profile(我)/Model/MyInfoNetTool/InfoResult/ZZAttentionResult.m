//
//  ZZAttentionResult.m
//  TalentService
//
//  Created by charles on 15/9/21.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZAttentionResult.h"
#import "ZZOtherUser.h"
@implementation ZZAttentionResult
+(NSDictionary *)objectClassInArray{
    return @{@"rows":[ZZOtherUser class ]};
}
@end
