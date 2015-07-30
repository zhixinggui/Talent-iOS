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
 *  ios自带的get请求方式
 *
 *  @return block
 */
-(void)getByApiName:(NSString *)apiName
             Params:(NSString *)params
            success:(SuccessBlock)success
            failure:(ErrorBlock)failure;

/**
 *  ios自带的post请求方式
 *
 *  @return block
 */
-(void)postByApiName:(NSString *)apiName
              Params:(NSDictionary*)params
             success:(SuccessBlock)success
             failure:(ErrorBlock)failure;

/**
 *  第三方的get请求方式
 */
-(void)AFGetByApiName:(NSString *)apiName
               Params:(id)params
              success:(SuccessBlock)success
              failure:(ErrorBlock)failure;

/**
 *  第三方的post请求方式
 */
-(void)AFPostByApiName:(NSString *)apiName
                Params:(id)params
               success:(SuccessBlock)success
               failure:(ErrorBlock)failure;

/**
 *  第三方的post上传多张图片请求方式
 */
-(void)AFPostImageByApiName:(NSString *)apiName
                     Params:(id)params
                ImagesArray:(NSArray*)images
                    success:(SuccessBlock)success
                    failure:(ErrorBlock)failure;

/**
 *  第三方的post上传单张图片请求方式
 */
-(void)AFPostImageByApiName:(NSString *)apiName
                  ImageName:(NSString*)imageName
                     Params:(id)params
                      Image:(UIImage*)image
                    success:(SuccessBlock)success
                    failure:(ErrorBlock)failure;
@end
