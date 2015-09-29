//
//  NSObject+ZZDataLogic.m
//  TalentService
//
//  Created by zhizhen on 15/9/28.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "NSObject+ZZDataLogic.h"

@implementation NSObject (ZZDataLogic)

@end

@implementation NSString (ZZDataLogic)
/**价格转换*/
+ (NSString *)dealFreePrice:(NSString *)originPrice
{
    NSString *str = originPrice;
    if ([str  safeString] && [str doubleValue] != 0) {
        // 小数点的位置
        return [self  dealPrice:str];
    }else{
        return @"免费";
    }
}

+ (NSString *)dealPrice:(NSString *)originPrice{
    NSString *str = originPrice;
    NSUInteger dotIndex = [str rangeOfString:@"."].location;
    if (dotIndex != NSNotFound && str.length - dotIndex > 2) { // 小数超过2位
        str = [str substringToIndex:dotIndex + 3];
    }
    return [str  stringByAppendingString:@"元"];
}
@end

@implementation NSNumber (ZZDataLogic)
+ (NSNumber *)dealNum:(NSNumber *)number{
    NSString *str = [number description];
    // 小数点的位置
    NSUInteger dotIndex = [str rangeOfString:@"."].location;
    if (dotIndex != NSNotFound && str.length - dotIndex > 2) { // 小数超过2位
        str = [str substringToIndex:dotIndex + 3];
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter  alloc]init];
    return  [numberFormatter numberFromString:str];
}
@end