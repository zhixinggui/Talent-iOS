//
//  ZZSecurityButton.m
//  TalentService
//
//  Created by zhizhen on 15/7/29.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZSecurityButton.h"
@interface ZZSecurityButton ()
@property (nonatomic) NSInteger changeSecond;

@property (nonatomic, strong) NSTimer *timer;
@end
@implementation ZZSecurityButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
        self.exclusiveTouch = YES;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor  orangeColor];
    }
    return self;
}

-(void)setSecond:(NSUInteger)second{
    _second = second;
    self.changeSecond = second;
    [self  setButtonTitle];
}
//重写父类方法，加入title变换事件
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [super addTarget:target action:action forControlEvents:controlEvents];
    [super addTarget:self action:@selector(clicked:) forControlEvents:controlEvents];
}
//点击响应事件
- (void)clicked:(UIButton *)btn{
    btn.enabled = NO;
    btn.backgroundColor = [UIColor  grayColor];
    if (self.timer == nil) {//没有定时器，创建一个，创建后直接开始执行
     self.timer =    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:)  userInfo:nil repeats:YES];
    }else{//开启定时器
        [self.timer setFireDate:[NSDate distantPast]];
    }
    
}
//计时器方法
-(void)timerFireMethod:(NSTimer *)theTimer {
    self.changeSecond--;
    if (self.changeSecond < 0) {
        [self.timer setFireDate:[NSDate distantFuture]];
        self.enabled = YES;
        self.changeSecond = self.second;
        [self  setButtonTitle];
        self.backgroundColor = [UIColor orangeColor];
    }else{
        [self  setButtonTitle];
    }
}
//更新title
- (void)setButtonTitle{
     [self  setTitle:[NSString  stringWithFormat:@"%ld秒后重新获取",self.changeSecond] forState:UIControlStateDisabled];
}
//销毁当前按钮
- (void) clearButton{
    [self.timer invalidate];
     self.timer = nil;
}

-(void)dealloc{
    ZZLog(@"%@",[self  class]);
}
@end
