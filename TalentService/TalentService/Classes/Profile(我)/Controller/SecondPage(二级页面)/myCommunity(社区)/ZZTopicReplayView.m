//
//  ZZTopicReplayView.m
//  TalentService
//
//  Created by charles on 15/11/10.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZTopicReplayView.h"

@interface ZZTopicReplayView ()
@property (weak, nonatomic) IBOutlet UIView *replayBackgroundView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replayBackgroungViewHeight;

@end


@implementation ZZTopicReplayView

- (void)awakeFromNib {
    self.width = ScreenWidth;
    self.height = ScreenHeight;
    //通知
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma  mark  NSNotification
- (void)keyboardAppear:(NSNotification *)notification{
    //1.获取键盘的高度
    NSDictionary *userInfo = notification.userInfo;
    NSValue *value = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [value CGRectValue];
        NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
        UIViewAnimationOptions options = [userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
        [UIView animateWithDuration:duration delay:0 options:options animations:^{
            self.replayBackgroungViewHeight.constant = keyboardFrame.size.height;
        } completion:nil];
}

//键盘收起
- (void)keyboardDisappear:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    UIViewAnimationOptions options = [userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
    [UIView animateWithDuration:duration delay:0  options:options animations:^{
            self.replayBackgroungViewHeight.constant = 0;
    } completion:nil];
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}
@end
