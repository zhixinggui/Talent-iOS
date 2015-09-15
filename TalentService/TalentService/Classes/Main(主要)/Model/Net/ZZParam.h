//
//  ZZParam.h
//  TalentService
//
//  Created by zhizhen on 15/9/9.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZParam : NSObject
/** 接口名 */
@property (nonatomic, copy)NSString *cmd;
/** 请求参数 */
@property (nonatomic, strong) NSDictionary*  parameters;
/** token */
@property (nonatomic, copy)NSString *token;
@end
