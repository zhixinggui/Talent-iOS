//
//  NSDictionary+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "NSDictionary+Extension.h"
#import "NSObject+Extension.h"
@implementation NSDictionary (Extension)
- (NSString *)safeStringForKey:(id)aKey {
    return [[self objectForKey:aKey] safeString];
}

- (NSNumber *)safeNumberForKey:(id)aKey {
    return [[self objectForKey:aKey] safeNumber];
}

- (NSArray *)safeArrayForKey:(id)aKey {
    return [[self objectForKey:aKey] safeArray];
}

- (NSDictionary *)safeDictionaryForKey:(id)aKey {
    return [[self objectForKey:aKey] safeDictionary];
}
/**
 *  打印字典中的元素时，打印内容，不再只是内存地址
 *
 *  @param locale <#locale description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
@end
