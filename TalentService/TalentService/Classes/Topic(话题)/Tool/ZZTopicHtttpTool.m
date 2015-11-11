//
//  ZZTopicHtttpTool.m
//  TalentService
//
//  Created by zhizhen on 15/11/10.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZTopicHtttpTool.h"
#import "ZZHttpTool.h"
#import "ZZTopicType.h"
@implementation ZZTopicHtttpTool
+ (void)topicTypesSuccess:(void (^)(NSArray *topicTypes ,ZZNetDataType netDataType))success  failure:(void (^)(NSString *error , ZZNetDataType dataType))failure{
    ZZParam *param = [[ZZParam alloc]init];
    param.cmd = @"smart/system/dictList";
    param.parameters = @{@"typeCode":@"topicType"};
    param.token = [ZZLoginTool loginToken];
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(ZZBottomNetResult *json) {
        
        NSArray *topicTypes = [ZZTopicType  objectArrayWithKeyValuesArray:json.response.data];
        success(topicTypes,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType  netDataType) {
        
        failure(error,netDataType);
    }];
}
@end
