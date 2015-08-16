//
//  ZZTextField.m
//  TalentService
//
//  Created by zhizhen on 15/7/29.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZTextField.h"

@implementation ZZTextField
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
 
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > self.textContentLength ||[self  isRegex:string]) {
            return NO;
        }
    return YES;
}

- (BOOL)isRegex:(NSString*)candidate
{//(“^[A-Za-z0-9]+$”) ;
 //@"^[0-9]+$"  纯数字  只能输入由数字和26个英文字母组成的字符串：(“^[A-Za-z0-9]+$”) ;
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regexStr];
    return [emailTest evaluateWithObject:candidate];
}


- (BOOL)isPhoneNumber{
    NSString *telRegex = @"^1[34578]\\d{9}$";
    NSPredicate *prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [prediate evaluateWithObject:self];
}
- (BOOL)isSecutityNumber{
    NSString *telRegex = @"[0-9]{6}$";
    NSPredicate *prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [prediate evaluateWithObject:self];
}


- (BOOL)isPassWordWithMin:(NSUInteger)min max:(NSUInteger)max{
    NSString *telRegex = [NSString  stringWithFormat:@"[A-Za-z0-9]{%ld,%ld}$", min,max];
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",telRegex];
    return [emailTest evaluateWithObject:self];
}


@end
