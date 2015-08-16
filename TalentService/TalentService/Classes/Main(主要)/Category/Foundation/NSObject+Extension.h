//
//  NSObject+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)
- (id)safeValueFromJSON;

/**
 @brief 如果此对象是aClass则返回self，否则返回nil，
 */
- (id)safeObjectWithClass:(Class)aClass;

/**
 @brief 如果此对象是NSString则返回self，否则返回nil，
 */
- (NSString *)safeString;

/**
 @brief 如果此对象是NSNumber则返回self，否则返回nil，
 */
- (NSNumber *)safeNumber;

/**
 @brief 如果此对象是NSArray则返回self，否则返回nil，
 */
- (NSArray *)safeArray;

/**
 @brief 如果此对象是NSDictionary则返回self，否则返回nil，
 */
- (NSDictionary *)safeDictionary;

/**
 @brief 如果此对象是NSDate则返回self，否则返回nil，
 */
- (NSDate *)safeDate;

/**
 *  计算代码执行所耗时长
 *
 *  @param block 代码放在block中
 *
 *  @return 返回执行的时长，单位为s
 */
-(double)codeBlockCostTime:(void (^)(void))block;

- (CGSize)getiSizeWithAttString:(NSAttributedString *)attrStr size:(CGSize)size;
@end
