//
//  ZZFunctionShowTule.h
//  TalentService
//
//  Created by zhizhen on 15/9/2.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZZFunctionShowRuleDelegate <NSObject>

- (NSString *)name;

- (NSString *)showImageName;

@end
@protocol ZZActivityClassSelectorShowDele <NSObject>

- (NSString *)showInfo;

@end

@protocol ZZSelectorViewShowDele <NSObject>
//显示的文字
- (NSString *)content;

@end
@interface ZZFunctionShowRule : NSObject

@end
