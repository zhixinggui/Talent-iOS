//
//  ZZTopicResult.m
//  TalentService
//
//  Created by charles on 15/11/11.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZTopicResult.h"
#import "ZZTopic.h"

@implementation ZZTopicResult
+(NSDictionary *)objectClassInArray{
    return @{@"rows":[ZZTopic class ]};
}
@end
