//
//  ZZHomeHttpTool.m
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZHomeHttpTool.h"
#import "ZZHttpTool.h"
#import "ZZLoginUser.h"
@implementation ZZHomeHttpTool
+(void)homeRcommoned:(NSInteger)isRecom success:(void (^)(NSArray *, ZZNetDataType))succ failure:(void (^)(NSString *, ZZNetDataType))fail{
    
    ZZParam *param = [[ZZParam  alloc]init];
    param.cmd = @"smart/recommonedEredar";
    param.parameters = @{@"isRecommoned":@(isRecom)};
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        //objectArrayWithKeyValuesArray
        NSArray *array = [ZZLoginUser objectArrayWithKeyValuesArray:json];
    
        succ(array,ZZNetDataTypeSuccServer);
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        
        
    }];
    
}

+(void)homeServices:(ZZHomeServiceParam *)homeParam success:(void (^)(NSArray *, ZZNetDataType))succ failure:(void (^)(NSString *, ZZNetDataType))fail{
    
    ZZParam *param = [[ZZParam  alloc]init];
    param.cmd = @"smart/services/getPage";
    param.parameters = homeParam.keyValues;
    
    [ZZHttpTool  afPostByApiName:@"" Params:param success:^(id json) {
        
        
    } failure:^(NSString *error, ZZNetDataType netDataType) {
        
        
    }];
}
@end
