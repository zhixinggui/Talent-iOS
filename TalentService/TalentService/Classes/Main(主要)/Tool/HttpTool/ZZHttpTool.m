//
//  ZZHttpTool.m
//  TalentService
//
//  Created by zhizhen on 15/7/29.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZHttpTool.h"

#import "AFNetworking.h"

@implementation ZZHttpTool

static AFHTTPRequestOperationManager  *_manager;

+(void)initialize{//@"text/plain", @"text/html",
    _manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL  URLWithString:[baseUrl  copy]]];
    AFJSONRequestSerializer *jsonRequest = [AFJSONRequestSerializer  serializer];
    _manager.requestSerializer = jsonRequest;
    _manager.requestSerializer.timeoutInterval = responseTime;
    
//    AFJSONResponseSerializer *response = [AFJSONResponseSerializer  serializer];
//    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html",  nil];

}


#pragma mark - Http 请求网络数据方法
/**
 *  ios自带的get请求方式
 *
 *  @return block
 */
+ (void)getByApiName:(NSString *)apiName
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
         //   failure(error);
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
+ (void)postByApiName:(NSString *)apiName
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
               // NSString*  str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
          
                id  jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
                if ([jsonData  isKindOfClass:[NSArray  class]]) {
                    NSDictionary*  dic = jsonData[0];
                    success(dic);
                }else{
                    success(jsonData);
                }
            }else {
              //  failure(error);
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
+ (void)afGetByApiName:(NSString *)apiName
                Params:(ZZParam *)param
               success:(SuccessBlock)Success
               failure:(ErrorBlock)Failure{
    
    [_manager GET:apiName parameters:[param  keyValues] success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
      [self  managerOriginJsonData:responseObject serverSuccess:^(id json) {
          ZZLog(@",succ,,%@",json);
          Success(json);
      } serverFail:^(NSString *error, ZZNetDataType dataType) {
          ZZLog(@",fail,,%@",error);
          Failure (error,dataType);
      }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //QQLog(@"Error: %@", error);
        Failure(NetFailTipStr,ZZNetDataTypeFailLocal);
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
+(void)afPostByApiName:(NSString *)apiName
                Params:(ZZParam *)param
               success:(SuccessBlock)Success
               failure:(ErrorBlock)Failure{
    
    [_manager POST:apiName parameters:[param  keyValues] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
     
        ZZLog(@"JSON: %@", responseObject);
        
        [self  managerOriginJsonData:responseObject serverSuccess:^(id json) {
            
            Success(json);
        } serverFail:^(NSString *error, ZZNetDataType dataType) {
            
            Failure (error,dataType);
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        ZZLog(@"Error: %@", error);
        Failure(NetFailTipStr,ZZNetDataTypeFailLocal);
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
+(void)afPostImageByApiName:(NSString *)apiName
                     Params:(ZZParam *)param
                ImagesArray:(NSArray *)fileParams
                    success:(SuccessBlock)Success
                    failure:(ErrorBlock)Failure{
    
    [_manager POST:apiName parameters:[param  keyValues] constructingBodyWithBlock:^(id formData) {
        for (ZZFileParam *fileParam in fileParams) {
            
            [formData  appendPartWithFileData:fileParam.data name:fileParam.name fileName:fileParam.fileName mimeType:fileParam.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        [self  managerOriginJsonData:responseObject serverSuccess:^(id json) {

            Success(json);
        } serverFail:^(NSString *error, ZZNetDataType dataType) {
            
            Failure (error,dataType);
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         Failure(NetFailTipStr,ZZNetDataTypeFailLocal);
    }];
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
+(void)AFPostImageByApiName:(NSString *)apiName
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


/**
 *  业务逻辑（数据库）状态判断
 *
 *  @param jsonData <#jsonData description#>
 *  @param succ     <#succ description#>
 *  @param failure  <#failure description#>
 */
+ (void)managerJsonData:(id)jsonData  netSuccess: (void (^)(id json))succ  netFail :(void (^)(NSString *reason))failure{
   
    if ([[[jsonData safeDictionary] objectForKey:@"status"] integerValue]==1) {
        id dataDic = [[jsonData safeDictionary] objectForKey:@"data"];
        succ(dataDic);
    }else {
        failure([[jsonData safeDictionary] objectForKey:@"msg"]);
    }
}
/**
 *  服务器服务状态判断
 *
 *  @param jsonOriginData <#jsonOriginData description#>
 *  @param succ           <#succ description#>
 *  @param failure        <#failure description#>
 */
+ (void)managerOriginJsonData:(id)jsonOriginData  serverSuccess: (void (^)(id json))succ  serverFail :(void (^)(NSString *error, ZZNetDataType dataType))failure{
    NSDictionary *originDic = [jsonOriginData safeDictionary];
    NSInteger statusCode=   [[originDic objectForKey:@"statusCode"]integerValue];
   
    if (statusCode >= 200 &&statusCode < 302) {//服务器状态正常
        
        NSDictionary *responseDic = [[originDic  objectForKey:@"response"]safeDictionary];
        [self  managerJsonData:responseDic netSuccess:^(id json) {
                succ(json);
          
        } netFail:^(NSString *reason) {
            failure(reason,ZZNetDataTypeFailNet);
        }];
        
    }else if(statusCode == 403){//token失效
        NSDictionary *errorDic = [[originDic objectForKey:@"error"]safeDictionary];
        NSString *errorStr = [[errorDic objectForKey:@"errorInfo"]safeString];
        if (errorStr.length) {
      
        }else{
            errorStr = @"让服务器休息下";
        }
        //发出通知
        NSNotification *noti = [NSNotification  notificationWithName:ZZTokenIsNoActive object:nil userInfo:@{ZZTokenIsNoActiveError:errorStr}];
        [[NSNotificationCenter defaultCenter]postNotification:noti];
        
        failure(errorStr,ZZNetDataTypeFailServer);
    }else{//服务器连接失败
        NSDictionary *errorDic = [[originDic objectForKey:@"error"]safeDictionary];
        NSString *errorStr = [[errorDic objectForKey:@"errorInfo"]safeString];
        if (errorStr.length) {
            
        }else{
            errorStr = @"让服务器休息下";
        }
        failure(errorStr,ZZNetDataTypeFailServer);
    }
}
@end
