//
//  ZZCityTool.h
//  TalentService
//
//  Created by zhizhen on 15/9/8.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "ZZProvince.h"
#import "ZZCity.h"
#import "ZZCounty.h"
@interface ZZCityTool : NSObject
singleton_interface(ZZCityTool);
/**
 *  所有的城市组
 */
@property (strong, nonatomic, readonly) NSArray *provinceGroups;

- (ZZCounty *)getCountyWithCountyId:(NSUInteger )countyId;

- (ZZCity *)getCityWithCityId:(NSUInteger )cityId;

- (ZZProvince *)getProvinceWithProvinceId:(NSUInteger )provinceId;
@end
