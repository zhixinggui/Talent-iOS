//
//  ZZHttpTool.h
//  TalentService
//
//  Created by zhizhen on 15/7/29.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZParam.h"
#import "ZZBottomNetResult.h"
#import "ZZLoginUserTool.h"
typedef void(^SuccessBlock)(ZZBottomNetResult *json);
typedef void(^ErrorBlock)(NSString *error, ZZNetDataType  netDataType);
@interface ZZHttpTool : NSObject


///**
// *  第三方的get请求方式
// */
//+(void)afGetByApiName:(NSString *)apiName
//               Params:(ZZParam *)param
//              success:(SuccessBlock)Success
//              failure:(ErrorBlock)Failure;

/**
 *  第三方的post请求方式
 */
+(void)afPostByApiName:(NSString *)apiName
                Params:(ZZParam *)param
               success:(SuccessBlock)Success
               failure:(ErrorBlock)Failure;

/**
 *  第三方的post上传多张图片请求方式
 */
+(void)afPostImageByApiName:(NSString *)apiName
                     Params:(ZZParam *)param
                ImagesArray:(NSArray *)fileParams
                    success:(SuccessBlock)Success
                    failure:(ErrorBlock)Failure;


@end
