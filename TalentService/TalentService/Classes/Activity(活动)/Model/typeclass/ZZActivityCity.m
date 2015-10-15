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
    
    for (int i = 0; i < 4; i++) {
        ZZActivityCity *city = [[ZZActivityCity  alloc]init];
        switch (i) {
            case 0:
                city.cityName = @"全部城市";
                
                break;
            case 1:
                city.cityName = @"北京";
                city.cityNumber = 110100;
                break;
            case 2:
                city.cityName = @"上海";
                city.cityNumber = 310100;
                break;
            case 3:
                city.cityName = @"广州";
                city.cityNumber = 440100;
                break;
                
        }
        [array  addObject:city];
    }
    return array;
}
@end
