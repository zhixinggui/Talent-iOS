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

    _userSmallImg = [[userSmallImg stringByAppendingString:ZZImageUrlAppend(120.0, NO)]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(void)setBackgroundImg:(NSString *)backgroundImg{
    _backgroundImg = [backgroundImg  getUrlUseEncodAppend:ZZImageUrlAppend(ScreenWidth, NO)];
}
@end

