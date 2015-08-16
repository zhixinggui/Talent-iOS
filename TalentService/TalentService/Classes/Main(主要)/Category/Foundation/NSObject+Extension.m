//
//  NSObject+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "NSObject+Extension.h"
#import <mach/mach_time.h>
@implementation NSObject (Extension)
- (id)safeValueFromJSON
{
    return self == [NSNull null] ? nil : self;
}

- (id)safeObjectWithClass:(Class)aClass
{
    if ([self isKindOfClass:aClass]) {
        return self;
    } else {
        //        NSAssert(NO,
        //                 @"Object class not matched, self is %@, should be %@",
        //                 NSStringFromClass([self class]),
        //                 NSStringFromClass(aClass));
        return nil;
    }
}

- (NSString *)safeString
{
    return [self safeObjectWithClass:[NSString class]];
}

- (NSNumber *)safeNumber
{
    return [self safeObjectWithClass:[NSNumber class]];
}

- (NSArray *)safeArray
{
    return [self safeObjectWithClass:[NSArray class]];
}

- (NSDictionary *)safeDictionary
{
    return [self safeObjectWithClass:[NSDictionary class]];
}

- (NSDate *)safeDate
{
    return [self safeObjectWithClass:[NSDate class]];
}

-(double)codeBlockCostTime:(void (^)(void))block{
    uint64_t begin = mach_absolute_time();//开始时间
    
    block();
    uint64_t end = mach_absolute_time();//结束时间
    
    uint64_t middle  = end - begin;
   return MachTimeToSecs(middle);
}

double MachTimeToSecs(uint64_t time)
{
    mach_timebase_info_data_t timebase;
    mach_timebase_info(&timebase);
    return (double)time * (double)timebase.numer /
    (double)timebase.denom /1e9;
}

- (CGSize)getiSizeWithAttString:(NSAttributedString *)attrStr size:(CGSize)size{
    CGSize  backSize = [attrStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    return CGSizeMake(ceil(backSize.width)+1, ceil(backSize.height));
    
}


@end
