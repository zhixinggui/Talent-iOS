//
//  UIView+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
//设置frame
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

/**
 *  当前视图在父视图中位置
 *
 *  @return 是父视图的第几个子视图
 */
- (NSUInteger)getSubviewIndex;

/**
 *  把自己移到父视图的最前面
 */
- (void)bringToFront;

/**
 *  把自己移到父视图的最后面
 */
- (void)sendToBack;

/**
 *  把当前视图在父视图中的层级往前移一位
 */
- (void)bringOneLevelUp;

/**
 *  把当前视图在父视图中的层级往后移一位
 */
- (void)sendOneLevelDown;

/**
 *  当前视图是否是在父视图中的层级最前面
 *
 *  @return yes  在最前面
 */
- (BOOL)isInFront;

/**
 *  当前视图是否是在父视图中的层级最后面
 *
 *  @return yes  在最后面
 */
- (BOOL)isAtBack;

/**
 *  交换视图在父视图中的层级
 *
 *  @param swapView 与当前视图对换层级
 */
- (void)swapDepthsWithView:(UIView*)swapView;

/**
 *  移除所有子视图
 */
- (void)removeAllSubviews;

/**
 *  根据tag值，移除子视图
 *
 *  @param tag 待移除的视图的tag
 */
- (void)removeSubViewByTag:(NSUInteger)tag;

/**
 *  移除数组中的视图
 *
 *  @param views 待移除的视图数组
 */
- (void)removeSubViews:(NSArray *)views;

/**
 *  这个视图是否是子视图
 *
 *  @param subView 待判定的视图
 *
 *  @return yes
 */
- (BOOL)containsSubView:(UIView *)subView;

/**
 *  子视图中是否有个视图是class类型
 *
 *  @param classt 视图类型
 *
 *  @return yes
 */
- (BOOL)containsSubViewOfClassType:(Class)classt;

/**
 *  设置抖动动画
 *
 *  @param offsetX     x轴移动位置，默认十个点
 *  @param duration    时长，默认.06
 *  @param repeatCount 重复次数，默认3次
 */
- (void)shakeAnimation:(CGFloat)offsetX duration:(CGFloat)duration repeatCount:(NSUInteger)repeatCount;

- (NSMutableAttributedString *)getAttributedStringWithText:(NSString *)text paragraphSpacing:(CGFloat)paragraphSpacing lineSpace:(CGFloat)lineSpace stringCharacterSpacing:(CGFloat)stringCharacterSpacing  textAlignment:(NSTextAlignment) textAlignment font:(UIFont *)font  color:(UIColor *)color;
@end
