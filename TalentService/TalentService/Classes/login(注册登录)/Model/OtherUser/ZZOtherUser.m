//
//  ZZOtherUser.m
//  TalentService
//
//  Created by 张亮亮 on 15/9/13.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZOtherUser.h"

@implementation ZZOtherUser
//+(NSDictionary *)replacedKeyFromPropertyName{
//    return @{@"userRole":@"contentMaps"};
//}
+(NSDictionary *)objectClassInArray{
    return @{@"userRole":[ZZUserRole class ]};
}
@end
