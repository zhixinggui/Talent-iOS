//
//  ZZPopMenu.m
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//
#define MaxHeight (ScreenHeight- 180)
#import "ZZPopMenu.h"
@interface ZZPopMenu()

/**
 *  最底部的遮盖 ：屏蔽除菜单以外控件的事件
 */
@property (nonatomic, weak) UIButton *cover;
/**
 *  容器 ：容纳具体要显示的内容contentView
 */
@property (nonatomic, weak) UIImageView *container;
@end
@implementation ZZPopMenu

#pragma mark - 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** 添加菜单内部的2个子控件 **/
        // 添加一个遮盖按钮
        UIButton *cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor clearColor];
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.cover = cover;
        
        // 添加带箭头的菜单图片
        UIImageView *container = [[UIImageView alloc] init];
        container.userInteractionEnabled = YES;
        container.backgroundColor = [UIColor  clearColor];
        [self addSubview:container];
        self.container = container;

    }
    return self;
}

- (instancetype)initWithContentView:(UIView *)contentView
{
    if (self = [super init]) {
        self.contentView = contentView;
    }
    return self;
}

+ (instancetype)popMenuWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithContentView:contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cover.frame = self.bounds;
}

#pragma mark - 内部方法
#pragma mark - 内部方法
- (void)coverClick
{
    [self dismiss];
}

#pragma mark - 公共方法


- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        self.cover.backgroundColor = [UIColor blackColor];
        self.cover.alpha = 0.3;
    } else {
        self.cover.backgroundColor = [UIColor clearColor];
        self.cover.alpha = 1.0;
    }
}


- (void)setBackground:(UIImage *)background
{
    self.container.image = background;
}

-(void)setContentView:(UIView *)contentView{
    _contentView = contentView;
      [self.container  addSubview:contentView];
}
- (void)showInRect:(CGRect)rect
{
    // 添加菜单整体到窗口身上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = window.bounds;
    [window addSubview:self];
    
    // 设置容器的frame
    self.container.frame = rect;
    [self.container addSubview:self.contentView];
    
    // 设置容器里面内容的frame
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottomMargin = 8;
    
    self.contentView.y = topMargin;
    self.contentView.x = leftMargin;
    self.contentView.width = self.container.width - leftMargin - rightMargin;
    self.contentView.height = self.container.height - topMargin - bottomMargin;
}
/**
 *  显示
 */
- (void)showFrom:(UIView *)from
{
    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 2.添加自己到窗口上
    [window addSubview:self];
    
    // 3.设置尺寸
    self.frame = window.bounds;
    
    // 4.调整灰色图片的位置
    // 默认情况下，frame是以父控件左上角为坐标原点
    // 转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    //    CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    
    self.container.y = CGRectGetMaxY(newFrame);
    self.container.x = CGRectGetMinX(newFrame);
    self.contentView.height = self.contentView.height > MaxHeight ? MaxHeight : self.contentView.height;
    self.contentView.y = 5;
    self.contentView.x = 5;
 self.contentView.width = CGRectGetWidth(from.frame) - 10;
    // 设置灰色的高度
    self.container.height = CGRectGetHeight(self.contentView.frame) + 11;
    // 设置灰色的宽度
    self.container.width = CGRectGetWidth(from.frame);
 
}
- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(popMenuDidDismissed:)]) {
        [self.delegate popMenuDidDismissed:self];
    }
   
    [self removeFromSuperview];
}

@end
