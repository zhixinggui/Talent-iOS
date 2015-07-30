//
//  NSString+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  移除字符串前后的回车和空格
 *
 *  @return 返回格式化后的字符串
 */
-(NSString*)removeWhitespaceAndNewlineCharacter;
/**
 *  根据字数截取字符串
 *
 *  @param wordCount 需要的字符数
 *
 *  @return 返回截取后的字符串
 */
- (NSString*)subStringFromTitleOrcontentWithLength:(NSUInteger)wordCount;

/**
 *  计算字符串高度
 *
 *  @param font <#font description#>
 *  @param maxW <#maxW description#>
 *
 *  @return <#return value description#>
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

/**
 *  老版本比较
 *
 *  @param otherVersion 比较的版本号
 *
 *  @return yes：比otherVersion老
 */
- (BOOL) sOlderVersionThan:(NSString*)otherVersion;

/**
 *  新版本比较
 *
 *  @param otherVersion 比较的版本号
 *
 *  @return yes：比otherVersion新
 */
- (BOOL)isNewerVersionThan:(NSString*)otherVersion;

/**
 *  计算字符长度，一个汉字为两个字符，两个英文字母为一个字符
 *
 *  @return <#return value description#>
 */
- (NSUInteger)unicodeLength;
@end
