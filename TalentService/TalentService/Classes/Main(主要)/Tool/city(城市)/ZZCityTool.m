//
//  ZZCityTool.m
//  TalentService
//
//  Created by zhizhen on 15/9/8.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZCityTool.h"

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

- (ZZCounty *)getCountyWithCountyId:(NSUInteger )countyId{
    ZZCounty *backCounty = nil;
    for (ZZProvince *province in self.provinceGroups) {
        for (ZZCity  * city in province.cities) {
            for (ZZCounty *county in city.counties) {
                if (county.countyId == countyId) {
                    backCounty = county;
                    break;
                }
            }
        }
    }
    return backCounty;
}

- (ZZCity *)getCityWithCityId:(NSUInteger )cityId{
    ZZCity *backCity = nil;
    for (ZZProvince *province in self.provinceGroups) {
        for (ZZCity  * city in province.cities) {
                if (city.cityId == cityId) {
                    backCity = city;
                    break;
                }
        }
    }
    return backCity;
}

- (ZZProvince *)getProvinceWithProvinceId:(NSUInteger )provinceId{
    ZZProvince *backProvince = nil;
    for (ZZProvince *province in self.provinceGroups) {
            if (province.provinceId == provinceId) {
                backProvince = province;
                break;
            }
    }
    return backProvince;
}
@end
