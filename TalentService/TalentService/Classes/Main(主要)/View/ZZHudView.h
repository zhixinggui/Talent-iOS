//
//  ZZHudView.h
//  萌宝派
//
//  Created by zhizhen on 14-11-5.
//  Copyright (c) 2014年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZHudView : UILabel
/**
 *  <#Description#>
 *
 *  @param message <#message description#>
 *  @param time    为0 时  不会自动隐藏
 *  @param view    <#view description#>
 *
 *  @return <#return value description#>
 */
+ (ZZHudView *)showMessage:(NSString *)message time:(NSTimeInterval )time toView:(UIView *)view;

-(void)addTarget:(id)target action:(SEL)action;

@end
