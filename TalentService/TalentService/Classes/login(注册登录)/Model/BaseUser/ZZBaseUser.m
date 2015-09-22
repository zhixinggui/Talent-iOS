//
//  ZZBaseUser.m
//  TalentService
//
//  Created by 张亮亮 on 15/9/13.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//
#define ZZImageScrwidth  [NSString  stringWithFormat:@"@%.0fw_1pr_2o_1l",60*[UIScreen  mainScreen].scale]
#import "ZZBaseUser.h"
#import "ZZUserRole.h"
@implementation ZZBaseUser


-(void)setUserSmallImg:(NSString *)userSmallImg{
    NSString *urlString = [NSString  stringWithFormat:@"%@%@",userSmallImg,ZZImageScrwidth];
    //转字符串
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _userSmallImg = urlString;
}
@end

