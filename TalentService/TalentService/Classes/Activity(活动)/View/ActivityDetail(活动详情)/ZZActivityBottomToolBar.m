//
//  ZZActivityBottomToolBar.m
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityBottomToolBar.h"

@implementation ZZActivityBottomToolBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ZZViewBackColor;
        [self  setUpTopShadow];
    }
    return self;
}

-(void)setBtns:(NSArray *)btns{
    _btns = btns;
    for (UIButton *btn in btns) {
        [self  addSubview:btn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSInteger btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount ;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.width = btnW - 1;
        btn.height = btnH;
        btn.y = 0;
        btn.x = i * (btnW+1);
    }
}

-(void)drawRect:(CGRect)rect{
    [ZZDarkGrayColor  set];
    CGFloat margin = 5;
    UIRectFill(CGRectMake(rect.size.width/2, rect.origin.y+margin, 0.1, rect.size.height-2*margin));

}
@end
