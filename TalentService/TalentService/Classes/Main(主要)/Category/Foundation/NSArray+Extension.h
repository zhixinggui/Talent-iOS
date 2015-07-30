//
//  NSArray+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)
-(id)objectAtIndexIfIndexInBounds:(NSUInteger)index;

/**
 @brief   取一个安全的NSString对象
 @return  index对应的实例不是NSString则返回nil
 */
- (NSString *)safeStringAtIndex:(NSUInteger)index;

/**
 @brief   取一个安全的NSNumber对象
 @return  index对应的实例不是NSNumber则返回nil
 */
- (NSNumber *)safeNumberAtIndex:(NSUInteger)index;

/**
 @brief   取一个安全的NSArray对象
 @return  index对应的实例不是NSArray则返回nil
 */
- (NSArray *)safeArrayAtIndex:(NSUInteger)index;

/**
 @brief   取一个安全的NSDictionary对象
 @return  index对应的实例不是NSDictionary则返回nil
 */
- (NSDictionary *)safeDictionaryAtIndex:(NSUInteger)index;
@end
