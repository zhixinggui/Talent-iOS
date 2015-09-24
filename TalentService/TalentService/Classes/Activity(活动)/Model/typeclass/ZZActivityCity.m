//
//  ZZActivityCity.m
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityCity.h"

@implementation ZZActivityCity
//显示的文字
- (NSString *)content{
    return self.cityName;
}
+ (NSArray *)arrays{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        ZZActivityCity *city = [[ZZActivityCity  alloc]init];
        city.cityName = [ NSString  stringWithFormat:@"北京%d",i];
        [array  addObject:city];
    }
    return array;
}
@end
