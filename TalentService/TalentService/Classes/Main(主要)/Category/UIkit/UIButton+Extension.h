//
//  UIButton+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 * 设置普通状态与高亮状态的背景图片
 */
-(void)setN_BG:(NSString *)nbg H_BG:(NSString *)hbg;

/**
 * 设置普通状态与高亮状态的拉伸后背景图片
 */
-(void)setResizeN_BG:(NSString *)nbg H_BG:(NSString *)hbg;

/**
 *  加载网络的图片
 */
- (void)setUrlImage:(NSString *)urlStr;

@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *highlightedTitleColor;
@property (strong, nonatomic) UIColor *selectedTitleColor;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *highlightedTitle;
@property (copy, nonatomic) NSString *selectedTitle;

@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *highlightedImage;
@property (copy, nonatomic) NSString *selectedImage;

@property (copy, nonatomic) NSString *bgImage;
@property (copy, nonatomic) NSString *highlightedBgImage;
@property (copy, nonatomic) NSString *selectedBgImage;

- (void)addTarget:(id)target action:(SEL)action;
@end
