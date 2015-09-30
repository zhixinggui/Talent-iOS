//
//  ZZBaseUser.m
//  TalentService
//
//  Created by 张亮亮 on 15/9/13.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZBaseUser.h"
#import "ZZUserRole.h"
@implementation ZZBaseUser


-(void)setUserSmallImg:(NSString *)userSmallImg{
    NSString *str = ZZImageUrlAppend(120.0, NO);
    if ([userSmallImg  containsString:str]) {
        _userSmallImg = userSmallImg;
    }else{
        _userSmallImg = [userSmallImg  getUrlUseEncodAppend:str];
    }

}

-(void)setBackgroundImg:(NSString *)backgroundImg{
    _backgroundImg = [backgroundImg  getUrlUseEncodAppend:ZZImageUrlAppend(ScreenWidth, NO)];
}
@end

