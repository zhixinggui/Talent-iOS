//
//  ZZHudView.h
//  萌宝派
//
//  Created by zhizhen on 14-11-5.
//  Copyright (c) 2014年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZHudView : UILabel

+ (ZZHudView *)showMessage:(NSString *)message time:(NSTimeInterval )time toView:(UIView *)view;



@end
