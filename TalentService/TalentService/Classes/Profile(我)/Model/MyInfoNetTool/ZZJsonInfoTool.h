//
//  ZZJsonInfoTool.h
//  TalentService
//
//  Created by charles on 15/9/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZLoginUser.h"

#import "ZZOtherUser.h"
@interface ZZJsonInfoTool : NSObject
/**
 *  解析个人信息
 *
 *  @param dic <#dic description#>
 */
+(ZZOtherUser *)parseSelfInfomation:(NSDictionary*)dic;
/**
 *  修改解析
 *
 *  @param dic <#dic description#>
 */
+(void)parseChangeInformation:(NSDictionary*)dic;

///**
// *  关注列表解析
// */
//+(NSArray*)parseAttentionList:(NSDictionary*)dic;

@end
