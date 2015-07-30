//
//  NSString+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
//移除内容前后的空格和回车
-(NSString*)removeWhitespaceAndNewlineCharacter;{
    return [self   stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceAndNewlineCharacterSet]];
}

//截取一定长度的字符串
-(NSString*)subStringFromTitleOrcontentWithLength:(NSUInteger)wordCount{
    
    NSString*  text = self;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSUInteger  subWordCount = wordCount/2;
    NSData* da = [text dataUsingEncoding:enc];
    if (da.length>wordCount) {
        NSString*  str = nil;
        for (NSUInteger i = subWordCount; i<text.length; i++) {
            
            if ([[text substringToIndex:i] dataUsingEncoding:enc].length >= wordCount) {
                
                str = [text substringToIndex:i];
                
                break;
            }
        }
        return str;
    }else{
        return text;
    }
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    if(font == nil){
        font = [UIFont  systemFontOfSize:16];
    }
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(BOOL) isOlderVersionThan:(NSString*)otherVersion
{
    return ([self compare:otherVersion options:NSNumericSearch] == NSOrderedAscending);
}
-(BOOL) isNewerVersionThan:(NSString*)otherVersion
{
    return ([self compare:otherVersion options:NSNumericSearch] == NSOrderedDescending);
}

-(NSUInteger) unicodeLength
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
//    NSUInteger unicodeLength = asciiLength / 2;
//    if(asciiLength % 2) {
//        unicodeLength++;
//    }
    return asciiLength;
}
@end
