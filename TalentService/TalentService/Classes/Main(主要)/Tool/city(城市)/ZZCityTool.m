//
//  ZZCityTool.m
//  TalentService
//
//  Created by zhizhen on 15/9/8.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZCityTool.h"
#import "ZZProvince.h"
#import "ZZCity.h"
#import "ZZCounty.h"
#import "MJExtension.h"
@interface ZZCityTool ()
@property (strong, nonatomic) NSArray *provinceGroups;
@end
@implementation ZZCityTool
singleton_implementation(ZZCityTool);

- (NSArray *)provinceGroups
{
    if (!_provinceGroups) {
          NSData *jdata = [[NSData alloc]initWithContentsOfFile:[[NSBundle  mainBundle]pathForResource:@"address.json" ofType:nil]];
            NSError *error;
            id JsonObject=[NSJSONSerialization JSONObjectWithData:jdata
                                                          options:NSJSONReadingMutableLeaves
                                                            error:&error] ;
        _provinceGroups = [ZZProvince  objectArrayWithKeyValuesArray:JsonObject];
    }
    return _provinceGroups;
}
@end
