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

- (BOOL)isPassWordWithMin:(NSUInteger)min max:(NSUInteger)max{
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES ^[A-Za-z0-9]{%ld,%ld}$", min,max];
    return [emailTest evaluateWithObject:self.text];
}

- (BOOL)isPhoneNumber{
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES ^[1][34578][0-9]{9}$"];
    return [emailTest evaluateWithObject:self.text];
}
@end
