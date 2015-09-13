//
//  ZZCacheTool.h
//  TalentService
//
//  Created by 张亮亮 on 15/9/11.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZZApplyTalentParam;
@interface ZZCacheTool : NSObject

+(void)saveApplyTalentParam:(ZZApplyTalentParam *)applyTalentParam;

+(ZZApplyTalentParam *)readApplyTalentParam;

+(void)clearApplyTalentParam;

@end
