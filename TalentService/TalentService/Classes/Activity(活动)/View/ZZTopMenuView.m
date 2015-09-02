//
//  ZZTopMenuView.m
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZTopMenuView.h"

#define margin 0
@interface ZZTopMenuView ()

@end
@implementation ZZTopMenuView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
        self.layer.shadowColor = ZZSeparGrayColor.CGColor;//shadowColor阴影颜色
        self.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        self.layer.shadowRadius = 2;//阴影半径，默认3
    }
    return self;
}

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
