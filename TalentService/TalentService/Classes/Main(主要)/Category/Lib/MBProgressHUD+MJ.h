//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MJ)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;

+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;
//显示提示文字，没有图片的
+ (MBProgressHUD *)showTipContent:(NSString *)content;

+ (MBProgressHUD *)showTipContent:(NSString *)content toView:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view;

+ (void)hideHUD;

+ (void)showNetActivityIndicatorViewWithText:(NSString *)text view:(UIView *)view;

+ (void)showNetLoadFailWithText:(NSString *)text view:(UIView *)view target:(id)target action:(SEL)action  isBack:(BOOL)back;

+ (void)showMessageClearBackView:(NSString *)message toView:(UIView *)view;

+ (void)showMessageClearBackView:(NSString *)message toView:(UIView *)view   yoffest:(CGFloat )y;
@end
