//
//  ZZBottomNetResult.h
//  TalentService
//
//  Created by zhizhen on 15/10/23.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZBottomNetError.h"
#import "ZZBottomNetResponse.h"
@interface ZZBottomNetResult : NSObject

@property (nonatomic, copy)NSString *clientIp;
/**其他扩展信息*/
@property (nonatomic, strong) NSDictionary *extraInfo;
@property (nonatomic, copy)NSString *messageId;
/**没有错误信息为null, 不为null时请参看**错误处理**部分*/
@property (nonatomic, strong)ZZBottomNetError *error;
/**请求的唯一ID*/
@property (nonatomic, copy)NSString *requestId;
/**statusCode*/
@property (nonatomic )NSInteger statusCode;
/**请求的命令URL*/
@property (nonatomic, copy)NSString *cmd;
/**业务数据，json格式*/
@property (nonatomic, strong)ZZBottomNetResponse *response;
/**本次请求耗时（毫秒）*/
@property (nonatomic) NSUInteger duration;
/**服务器返回响应的时间*/
@property (nonatomic, copy)NSString *responseTime;
/**服务器返回响应的时间戳（毫秒）*/
@property (nonatomic) NSUInteger responseTimestamp;
/**调试信息*/
@property (nonatomic, copy)NSString *debugInfo;
/**是否从缓存中返回结果*/
@property (nonatomic) BOOL usedCache;

@end
