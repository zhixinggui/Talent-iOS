//
//  UILabel+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
- (void)setDefineText:(NSString *)text{
    self.numberOfLines = 0;
    self.attributedText =  [self  getAttributedStringWithText:text paragraphSpacing:ZZParagraphSpace lineSpace:ZZLineSpace stringCharacterSpacing:ZZCharSpace textAlignment:NSTextAlignmentLeft font:self.font color:self.textColor];
}
@end
