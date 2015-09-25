//
//  ZZMyInfoModel.h
//  TalentService
//
//  Created by zhizhen on 15/9/24.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZMyInfoModel : NSObject
@property (nonatomic, copy)NSString *iconName;
@property (nonatomic, copy)NSString *text;
@property (nonatomic) Class classType;
- (instancetype)initWithText:(NSString *)text iconName:(NSString *)iconName classType:(Class)classType;

+ (instancetype)myInfoModelWithText:(NSString *)text iconName:(NSString *)iconName classType:(Class)classType;
@end
