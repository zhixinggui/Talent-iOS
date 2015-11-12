//
//  ZZTopicHtttpTool.h
//  TalentService
//
//  Created by zhizhen on 15/11/10.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZTopicResult.h"
#import "ZZTopicParam.h"
@interface ZZTopicHtttpTool : NSObject
/**话题类型*/
+ (void)topicTypesSuccess:(void (^)(NSArray *topicTypes ,ZZNetDataType netDataType))success  failure:(void (^)(NSString *error , ZZNetDataType dataType))failure;

/**话题列表*/
+ (void)topicListWithTopicType:(ZZTopicParam *)topicParam Success:(void (^)(ZZTopicResult *topicResult ,ZZNetDataType netDataType))success  failure:(void (^)(NSString *error , ZZNetDataType dataType))failure;
@end
