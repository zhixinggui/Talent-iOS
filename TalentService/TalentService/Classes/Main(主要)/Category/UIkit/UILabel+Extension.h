//
//  UILabel+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/**
 *  计算自定义行高时的label的size，并设置行高显示
 *
 *  @param text      显示的文字内容
 *  @param maxW      最大宽度
 *  @param lineSpace 行间距
 *
 *  @return 对应的labelSize
 */
- (CGSize)setAttributedText:(NSString*)text  maxW:(CGFloat)maxW  lineSpace:(CGFloat)lineSpace;
@end
