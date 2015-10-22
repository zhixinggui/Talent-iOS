//
//  ZZIQKeyBoardTool.m
//  TalentService
//
//  Created by zhizhen on 15/9/2.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZIQKeyBoardTool.h"
#import "IQKeyboardManager.h"
@interface ZZIQKeyBoardTool ()

@end
@implementation ZZIQKeyBoardTool
+(void)load{
    /**shouldResignOnTouchOutside控制点击背景是否收起键盘*/
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

+(void)close{
    [IQKeyboardManager sharedManager].enable = NO;
}
+(void)open{
 
    [IQKeyboardManager sharedManager].enable = YES;
  
}

@end
