//
//  ZZCitySelector.h
//  TalentService
//
//  Created by zhizhen on 15/9/8.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZCity.h"
#import "ZZCounty.h"
#import "ZZProvince.h"
@class ZZCitySelector;
@protocol ZZCitySelectorDelegate <NSObject>

- (void)citySelectorSelect:(ZZCitySelector *)citySelector selectedProvince:(ZZProvince *)selectedProvince selectedCity:(ZZCity *)selectedCity selectedCounty:(ZZCounty *)selectedCounty;

@optional
- (void)citySelectorCancellSelect:(ZZCitySelector *)citySelector  ;
@end
@interface ZZCitySelector : UIView

+ (instancetype)citySelectorWithProvinceArray:(NSArray *)array  delegate:(id<ZZCitySelectorDelegate>) delegate;
@property (nonatomic, strong) ZZCity *selectedCity;
@property (nonatomic, strong) ZZProvince *selectedProvince;
@property (nonatomic, strong) ZZCounty *selectedCounty;

- (void)showAnimation;

- (void)dismissAnimation;
@end
