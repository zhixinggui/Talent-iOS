//
//  ZZActivity.m
//  TalentService
//
//  Created by zhizhen on 15/9/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivity.h"
#define ZZImageScrwidth  [NSString  stringWithFormat:@"@%.0fw_1pr.jpg",ScreenWidth * [UIScreen mainScreen].scale]
@implementation ZZActivity
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"activityId":@"id"};
}

-(void)setServicesImg:(NSString *)servicesImg{
    _servicesImg = servicesImg;
    self.imgUrl = [NSString  stringWithFormat:@"%@%@",servicesImg,ZZImageScrwidth];
}

-(void)setPrice:(NSNumber *)price{
    
    _price = [self  dealNumber:[price safeNumber]];
}

- (NSNumber *)dealNumber:(NSNumber *)sourceNumber
{
    NSString *str = [sourceNumber description];
    
    // 小数点的位置
    NSUInteger dotIndex = [str rangeOfString:@"."].location;
    if (dotIndex != NSNotFound && str.length - dotIndex > 2) { // 小数超过2位
        str = [str substringToIndex:dotIndex + 3];
    }
    
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    return [fmt numberFromString:str];
}
@end
