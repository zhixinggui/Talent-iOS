//
//  ZZIQKeyBoardTool.h
//  TalentService
//
//  Created by zhizhen on 15/9/2.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//  键盘弹起弹下

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface ZZIQKeyBoardTool : NSObject
singleton_interface(ZZIQKeyBoardTool);
-(void)close;
-(void)open;

@end
