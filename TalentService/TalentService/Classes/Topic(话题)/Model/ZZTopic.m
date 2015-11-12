//
//  ZZTopic.m
//  TalentService
//
//  Created by charles on 15/11/11.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZTopic.h"
#import "ZZTopicImage.h"
@implementation ZZTopic
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"topicId":@"id"};
}
+(NSDictionary *)objectClassInArray{
    return @{@"topicImgList":[ZZTopicImage class ]};
}
@end
