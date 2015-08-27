//
//  ZZTopMenuView.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZTopMenuView.h"

#define margin 4
@interface ZZTopMenuView ()

@end
@implementation ZZTopMenuView

-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.menuButtons.count;
    
    CGFloat width = self.frame.size.width/count;
    CGFloat height = self.frame.size.height ;
    
    CGFloat  subx = 0.5;
    CGFloat suby = 0;
    CGFloat subW = width - 2*subx;
    CGFloat subH = height - 2*margin ;
    
    for (NSUInteger i = 0; i< self.menuButtons.count; i++) {
        UIView *view = self.menuButtons[i];
        [self  addSubview:view];
        view.frame = CGRectMake(subx, suby, subW, subH);
        subx+=width;
      
    }
    [self  setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 设置绘图颜色
    [ZZSeparGrayColor set];
    
    // 矩形框的值
    NSUInteger count = self.menuButtons.count;
    
    CGFloat width = self.frame.size.width/count;
    CGFloat height = self.frame.size.height - 4*margin;
    for (NSUInteger i = 0; i< self.menuButtons.count-1; i++) {
    UIRectFill(CGRectMake(i*width+width-0.5, margin, 1, height));
    }
    
}
@end
