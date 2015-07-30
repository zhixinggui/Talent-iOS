//
//  ZZHttpTool.m
//  TalentService
//
//  Created by zhizhen on 15/7/29.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//
static  NSString * const baseUrl = @",,,,";
static  NSTimeInterval const responseTime = 60;
#import "ZZHttpTool.h"
#import "AFNetworking.h"
@interface ZZHttpTool ()
/**
 *  网络请求管理器
 */
@property(nonatomic,strong)AFHTTPRequestOperationManager*  manager;
@end
@implementation ZZHttpTool

singleton_implementation(ZZHttpTool)

-(AFHTTPRequestOperationManager *)manager{
    if (_manager == nil) {
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL  URLWithString:[baseUrl  copy]]];
        manager.requestSerializer.timeoutInterval = responseTime;
    }
    return _manager;
}

#pragma mark - Http 请求网络数据方法
/**
 *  ios自带的get请求方式
 *
 *  @return block
 */
- (void)getByApiName:(NSString *)apiName
              Params:(NSString *)params
             success:(SuccessBlock)success
             failure:(ErrorBlock)failure{
    
    NSString *path = nil;
    if (params.length) {
        path = [NSString stringWithFormat:@"%@%@?%@",baseUrl,apiName,params];
    }else{
        path = [NSString stringWithFormat:@"%@%@",baseUrl,apiName];
    }
    
    NSString*  pathStr = [path  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:pathStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            id  jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
            if ([jsonData  isKindOfClass:[NSArray  class]]) {
                NSDictionary*  dic = jsonData[0];
                success(dic);
            }else{
                success(jsonData);
            }
        }else {
            failure(error);
        }
        
    }];
    //开始请求
    [task resume];
}

/**
 *  ios自带的post请求方式
 *
 *  @return block
 */
- (void)postByApiName:(NSString *)apiName
               Params:(NSDictionary*)params
              success:(SuccessBlock)success
              failure:(ErrorBlock)failure{
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",baseUrl,apiName];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSError*  error;
    
    if ([NSJSONSerialization isValidJSONObject:params]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        [request  setHTTPBody:jsonData];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (!error) {
                NSString*  str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
          
                id  jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
                if ([jsonData  isKindOfClass:[NSArray  class]]) {
                    NSDictionary*  dic = jsonData[0];
                    success(dic);
                }else{
                    success(jsonData);
                }
            }else {
                failure(error);
            }
        }];
        //开始请求
        [task resume];
        
    }
}


#pragma mark 第三方请求方式
/**
 *  第三方的get请求方式 异步
 *
 *  @param apiName 接口名称
 *  @param params  参数
 *  @param success 成功block回调
 *  @param failure 失败block回调
 */
- (void)AFGetByApiName:(NSString *)apiName
                Params:(id)params
               success:(SuccessBlock)success
               failure:(ErrorBlock)failure{
    
    [self.manager GET:[NSString stringWithFormat:@"%@%@",baseUrl,apiName] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //QQLog(@"JSON: %@", responseObject);
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //QQLog(@"Error: %@", error);
        failure(error);
    }];
    
}
/**
 *  第三方的post请求方式 异步
 *
 *  @param apiName 接口名称
 *  @param params  参数
 *  @param success 成功block回调
 *  @param failure 失败block回调
 */
-(void)AFPostByApiName:(NSString *)apiName
                Params:(NSDictionary *)params
               success:(SuccessBlock)success
               failure:(ErrorBlock)failure{
    
    [self.manager POST:[NSString stringWithFormat:@"%@%@",baseUrl,apiName] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //QQLog(@"JSON: %@", responseObject);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //QQLog(@"Error: %@", error);
        failure(error);
    }];
    
}
/**
 *  第三方的post上传多张图片请求方式
 *
 *  @param apiName 上传api
 *  @param params  参数
 *  @param images  图片数组
 *  @param success -
 *  @param failure -
 */
-(void)AFPostImageByApiName:(NSString *)apiName
                     Params:(id)params
                ImagesArray:(NSArray*)images
                    success:(SuccessBlock)success
                    failure:(ErrorBlock)failure{
//    
//    [self.manager POST:apiName parameters:params constructingBodyWithBlock:^(id formData) {
//        
//        for (int i = 0; i<images.count; i++) {
//            NSData*  imageData = UIImageJPEGRepresentation([self fixOrientation:images[i]], 0.8);
//            NSString*  name =nil;
//            if (images.count == 1) {
//                name = @"imageFile";
//            }else{
//                name = [NSString   stringWithFormat:@"file%d",i+1];
//            }
//            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:@"image/jpeg"];
//        }
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        success(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//    }];
}
/**
 *  第三方的post上传单张图片请求方式
 *
 *  @param apiName 上传api
 *  @param params  参数
 *  @param image  图片
 *  @param success -
 *  @param failure -
 */
-(void)AFPostImageByApiName:(NSString *)apiName
                  ImageName:(NSString*)imageName
                     Params:(id)params
                      Image:(UIImage*)image
                    success:(SuccessBlock)success
                    failure:(ErrorBlock)failure{
//    
//    NSData*  imageData = UIImageJPEGRepresentation([self fixOrientation:image], 0.8);
//    [self.manager POST:apiName parameters:params constructingBodyWithBlock:^(id formData) {
//        [formData appendPartWithFileData:imageData name:imageName fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:@"image/jpeg"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        success(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//    }];
}

@end
