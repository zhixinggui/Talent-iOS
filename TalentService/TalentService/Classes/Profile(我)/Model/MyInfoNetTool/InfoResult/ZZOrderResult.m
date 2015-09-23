//
//  ZZOrderResult.m
//  TalentService
//
//  Created by charles on 15/9/23.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZOrderResult.h"
#import "ZZOrder.h"
@implementation ZZOrderResult
+(NSDictionary *)objectClassInArray{
    return @{@"rows":[ZZOrder class ]};
}
@end
