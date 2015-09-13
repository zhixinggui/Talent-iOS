//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:2];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication] keyWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication ] keyWindow];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+ (void)showNetActivityIndicatorViewWithText:(NSString *)text view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.color = [UIColor  clearColor];
    //设置字体颜色
    hud.label.textColor = [UIColor grayColor];
    if ([hud.indicator isKindOfClass:[UIActivityIndicatorView  class]]) {
        UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)hud.indicator;
        activityView.color = [UIColor  grayColor];
    }
    
    hud.labelText = text;
    
    //    // 设置图片
    //    UIActivityIndicatorView* activityView =  [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake1(0, 0, 50, 50)];
    //    hud.customView = activityView;
    //    [activityView  setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    //  hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeIndeterminate;
    
   
    
    // 1秒之后再消失
    // [hud hide:YES afterDelay:0.7];
}

+ (void)showNetLoadFailWithText:(NSString *)text view:(UIView *)view target:(id)target action:(SEL)action  isBack:(BOOL)back{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 快速显示一个提示信息
    //  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    if (back) {
        // 设置图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"error.png"]]];
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
        hud.dimBackground = YES;
    }else{
        hud.color = [UIColor clearColor];
        
        UIButton *button = [UIButton  buttonWithType:UIButtonTypeCustom];
        [button setTitle:text forState:UIControlStateNormal];
        [button  sizeToFit];
        button.backgroundColor = [UIColor  clearColor];
        [button setTitleColor:[UIColor  grayColor] forState:UIControlStateNormal];
        [button  addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [button  addTarget:hud action:@selector(hideSelf) forControlEvents:UIControlEventTouchUpInside];
        hud.customView = button;
        hud.mode = MBProgressHUDModeCustomView;
        hud.dimBackground = back;
    }
    // 隐藏时候从父控件中移除

    //
}
- (void)hideSelf{
    [self  hide:YES];
}
@end
