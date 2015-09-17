//
//  ZZJsonInfoTool.h
//  TalentService
//
//  Created by charles on 15/9/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZLoginUser.h"
@interface ZZJsonInfoTool : NSObject
/**
 *  解析个人信息
 *
 *  @param dic <#dic description#>
 */
+(void)parseSelfInfomation:(NSDictionary*)dic;
@end
