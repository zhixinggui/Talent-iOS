//
//  ZZPopMenu.h
//  TalentService
//
//  Created by zhizhen on 15/8/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ZZTopMenuArrowPositionCenter = 0,
    ZZTopMenuArrowPositionLeft = 1,
    ZZTopMenuArrowPositionRight = 2
} ZZTopMenuArrowPosition;
@class ZZPopMenu;
@protocol ZZPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(ZZPopMenu *)popMenu;

@end
@interface ZZPopMenu : UIView
//@property (nonatomic, weak) id<HMPopMenuDelegate> delegate;

@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;

@property (nonatomic, weak) id<ZZPopMenuDelegate> delegate;

@property (nonatomic, assign) ZZTopMenuArrowPosition arrowPosition;
/**
 *  初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;

/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;

/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;

/**
 *  关闭菜单
 */
- (void)dismiss;

@end
