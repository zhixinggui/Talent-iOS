//
//  ZZCityTool.h
//  TalentService
//
//  Created by zhizhen on 15/9/8.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface ZZCityTool : NSObject
singleton_interface(ZZCityTool);
/**
 *  所有的城市组
 */
@property (strong, nonatomic, readonly) NSArray *provinceGroups;

@end
