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
@property(nonatomic ,strong)IQKeyboardManager *manager;
@end
@implementation ZZIQKeyBoardTool
singleton_implementation(ZZIQKeyBoardTool);
-(IQKeyboardManager *)manager{
    if (!_manager) {
        _manager = [IQKeyboardManager sharedManager];
        _manager.enable = NO;
        _manager.shouldResignOnTouchOutside = YES;
        _manager.shouldToolbarUsesTextFieldTintColor = YES;
        _manager.enableAutoToolbar = NO;
    }
    return _manager;
}
-(void)close{
     self.manager.enable = NO;
}
-(void)open{
     self.manager.enable = YES;
}


@end
