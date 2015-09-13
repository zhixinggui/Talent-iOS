//
//  ZZCacheTool.m
//  TalentService
//
//  Created by 张亮亮 on 15/9/11.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//
#define ZZNumber  [ZZLoginUserTool  sharedZZLoginUserTool].loginUser.userId
#define ZZApplyTalentParamCache(number) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString  stringWithFormat:@"ApplyTalentParamCache_%ld.data",number]]

#import "ZZCacheTool.h"
#import "ZZLoginUserTool.h"
@implementation ZZCacheTool
+(void)saveApplyTalentParam:(ZZApplyTalentParam *)applyTalentParam{
  
     [NSKeyedArchiver archiveRootObject:applyTalentParam toFile:ZZApplyTalentParamCache(ZZNumber)];
    // 存进沙盒
//    [NSKeyedArchiver archiveRootObject:applyTalentParam toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString  stringWithFormat:@"ApplyTalentParamCache_%ld.data",[ZZLoginUserTool  sharedZZLoginUserTool].loginUser.userId]]];
}

+(ZZApplyTalentParam *)readApplyTalentParam{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:ZZApplyTalentParamCache(ZZNumber)];
}

+(void)clearApplyTalentParam{
    NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:ZZApplyTalentParamCache(ZZNumber) error:NULL];
}
@end
