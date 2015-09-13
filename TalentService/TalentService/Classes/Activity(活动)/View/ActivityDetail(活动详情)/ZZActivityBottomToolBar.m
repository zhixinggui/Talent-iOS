//
//  ZZActivityBottomToolBar.m
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityBottomToolBar.h"
@interface ZZActivityBottomToolBar()
@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, weak) UIButton *sportBtn;
@property (nonatomic, weak) UIButton *roastBtn;

@end
@implementation ZZActivityBottomToolBar
- (NSMutableArray *)btns
{
    if (_btns == nil) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.sportBtn = [self setupBtnWithIcon:@"support_20x20" title:@"点赞（100）"  backColor:ZZBlueColor  tag:ZZActivityBottomToolBarTypeSport];
        self.roastBtn = [self setupBtnWithIcon:@"supported_20x20" title:@"吐槽（2）"  backColor:ZZGreenColor  tag:ZZActivityBottomToolBarTypeRoast];
 
    }
    return self;
}


/**
 *  添加按钮
 *
 *  @param icon  图标
 *  @param title 标题
 */
- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title backColor:(UIColor *)backColor  tag:(ZZActivityBottomToolBarType)barType
{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = barType;
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.backgroundColor = backColor;
    btn.adjustsImageWhenHighlighted = NO;
    [btn  addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside ];
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSInteger btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = 0;
        btn.x = i * btnW;
    }
    

}

- (void)btnAction:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(bottomToolbar:didSelectedButton:)]) {
        [self.delegate bottomToolbar:self didSelectedButton:btn.tag];
    }
}

@end
