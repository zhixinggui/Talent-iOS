//
//  ZZOrder.m
//  TalentService
//
//  Created by zhizhen on 15/9/22.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZOrder.h"

@implementation ZZOrder

- (NSString *)showPrice:(NSNumber *)price{
    NSString *str = [price description];
    // 小数点的位置
    NSUInteger dotIndex = [str rangeOfString:@"."].location;
    if (dotIndex != NSNotFound && str.length - dotIndex > 2) { // 小数超过2位
        str = [str substringToIndex:dotIndex + 3];
    }
  
    return str ? str :@"免费";
}
@end
