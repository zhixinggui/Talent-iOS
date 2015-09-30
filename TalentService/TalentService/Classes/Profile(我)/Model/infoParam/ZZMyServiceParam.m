//
//  ZZMyServiceParam.m
//  TalentService
//
//  Created by charles on 15/9/29.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZMyServiceParam.h"

@implementation ZZMyServiceParam
+(void)initialize{
    [self referenceReplacedKeyWhenCreatingKeyValues:YES];
}

+(NSDictionary *)replacedKeyFromPropertyName{
    return  @{@"userId":@"id"};
}
@end
