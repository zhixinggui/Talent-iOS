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

/**
 *  根据自定义字符串 和限定高度求出实际高度
 *
 *  @param attrStr <#attrStr description#>
 *  @param size    <#size description#>
 *
 *  @return <#return value description#>
 */
- (CGSize)getiSizeWithAttString:(NSAttributedString *)attrStr size:(CGSize)size;

/**
 *  得到合适的大小 返回的数据不能超出限制的数据
 *
 *  @param limitSize  限制的size
 *  @param originSize 原始的size
 *
 *  @return 返回的合适的数据
 */
- (CGSize)sizeWithLimitSize:(CGSize)limitSize originSize:(CGSize)originSize;
@end
