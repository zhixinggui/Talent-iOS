//
//  UILabel+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
- (CGSize)setAttributedText:(NSString*)text  maxW:(CGFloat)maxW  lineSpace:(CGFloat)lineSpace{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString   alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle  alloc] init];
    
    paragraphStyle.alignment = self.textAlignment;
    
    //    paragraphStyle.maximumLineHeight = 60;  //最大的行高
    if (lineSpace < 0) {
        lineSpace = 0;
    }
    paragraphStyle.lineSpacing = lineSpace;  //行自定义行高度
    // [paragraphStyle setFirstLineHeadIndent:self.usernameLabel.frame.size.width + 5];//首行缩进 根据用户昵称宽度在加5个像素
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,text.length)];
    
    self.attributedText = attributedString;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize  frameSize = [self  sizeThatFits:maxSize];
    if (frameSize.width<maxW) {
        frameSize.width = maxW;
    }
    return frameSize;
}
@end
