//
//  ZZActivityDetailParam.m
//  TalentService
//
//  Created by 张亮亮 on 15/9/11.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityDetailParam.h"

@implementation ZZActivityDetailParam

+(void)initialize{
    [self referenceReplacedKeyWhenCreatingKeyValues:YES];
}

+(NSDictionary *)replacedKeyFromPropertyName{
    return    @{@"activityID":@"id"};
}

@end
