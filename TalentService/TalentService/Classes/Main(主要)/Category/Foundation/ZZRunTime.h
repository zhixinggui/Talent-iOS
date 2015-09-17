//
//  ZZRunTime.h
//  TalentService
//
//  Created by zhizhen on 15/9/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZRunTime : NSObject
/**
 * @brief 移魂大法
 * @param clazz 原方法的类
 * @param original 原方法
 * @param replacement 劫持后的方法
 */
+ (void)swizzleInstanceMethodWithClass:(Class)clazz originalSel:(SEL)original replacementSel:(SEL)replacement;
@end
@interface NSObject (uxyRuntime)

// class
+ (NSArray *)uxy_subClasses;
+ (NSArray *)uxy_classesWithProtocol:(NSString *)protocolName;

// method
+ (NSArray *)uxy_methods;
+ (NSArray *)uxy_methodsWithPrefix:(NSString *)prefix;
+ (NSArray *)uxy_methodsUntilClass:(Class)baseClass;
+ (NSArray *)uxy_methodsWithPrefix:(NSString *)prefix untilClass:(Class)baseClass;

+ (void *)uxy_replaceSelector:(SEL)sel1 withSelector:(SEL)sel2;

// property
+ (NSArray *)uxy_properties;
+ (NSArray *)uxy_propertiesUntilClass:(Class)baseClass;
+ (NSArray *)uxy_propertiesWithPrefix:(NSString *)prefix;
+ (NSArray *)uxy_propertiesWithPrefix:(NSString *)prefix untilClass:(Class)baseClass;



@end

@interface NSObject (XY_associated)
- (id)uxy_getAssociatedObjectForKey:(const char *)key;
- (void)uxy_setCopyAssociatedObject:(id)obj forKey:(const char *)key;
- (void)uxy_setRetainAssociatedObject:(id)obj forKey:(const char *)key;
- (void)uxy_setAssignAssociatedObject:(id)obj forKey:(const char *)key;
- (void)uxy_removeAssociatedObjectForKey:(const char *)key;
- (void)uxy_removeAllAssociatedObjects;
@end