//
//  ZZHttpTool.h
//  TalentService
//
//  Created by zhizhen on 15/7/29.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

typedef void(^SuccessBlock)(id json);
typedef void(^ErrorBlock)(NSError *error);
@interface ZZHttpTool : NSObject

singleton_interface(ZZHttpTool)


/**
 *  第三方的get请求方式
 */
-(void)afGetByApiName:(NSString *)apiName
               Params:(NSDictionary *)params
              success:(SuccessBlock)success
              failure:(ErrorBlock)failure;

/**
 *  第三方的post请求方式
 */
-(void)afPostByApiName:(NSString *)apiName
                Params:(NSDictionary *)params
               success:(SuccessBlock)success
               failure:(ErrorBlock)failure;

/**
 *  第三方的post上传多张图片请求方式
 */
-(void)afPostImageByApiName:(NSString *)apiName
                     Params:(NSDictionary *)params
                ImagesArray:(NSArray *)fileParams
                    success:(SuccessBlock)success
                    failure:(ErrorBlock)failure;


@end
