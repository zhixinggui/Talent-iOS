//
//  UIAlertView+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "UIAlertView+Extension.h"

@implementation UIAlertView (Extension)

-(void)dismissAfter:(int)time{
    
    [self performSelector:@selector(hideAnimated) withObject:nil afterDelay:time];
}
- (void)hideAnimated{

    [self dismissWithClickedButtonIndex:0 animated:YES];
}
@end
