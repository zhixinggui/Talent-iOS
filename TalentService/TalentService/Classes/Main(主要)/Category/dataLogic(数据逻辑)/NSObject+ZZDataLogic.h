//
//  NSObject+ZZDataLogic.h
//  TalentService
//
//  Created by zhizhen on 15/9/28.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZZDataLogic)

@end


@interface NSString (ZZDataLogic)
/**价格转换 0.00显示免费的*/
+ (NSString *)dealFreePrice:(NSString *)originPrice;

/**价格转换 0.00显示0.00的*/
+ (NSString *)dealPrice:(NSString *)originPrice;
@end

@interface NSNumber (ZZDataLogic)
/**处理数据小数位*/
+ (NSNumber *)dealNum:(NSNumber *)number;
@end