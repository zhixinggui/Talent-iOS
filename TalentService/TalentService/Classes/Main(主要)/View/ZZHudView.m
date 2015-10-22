//
//  ZZHudView.m
//  萌宝派
//
//  Created by zhizhen on 14-11-5.
//  Copyright (c) 2014年 ZZ. All rights reserved.
//

#import "ZZHudView.h"
#import "AppDelegate.h"

CGFloat const Maxheight = 40;
CGFloat  const  Minheight = 20;
CGFloat const Maxwidth = 100;
CGFloat  const  Minwidth = 20;

@interface ZZHudView ()
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;

@end
@implementation ZZHudView
+ (ZZHudView *)showMessage:(NSString *)message time:(NSTimeInterval )time toView:(UIView *)view{
  
    ZZHudView *hudView = [[ZZHudView  alloc]init];
    hudView.text = message;

    [hudView  showTime:time toView:view];
    return hudView;
    
}

- (void)showTime:(NSTimeInterval )time toView:(UIView *)view{
    
   
    if(view == nil || ![view  isKindOfClass:[UIView  class]]){
      view = [UIApplication  sharedApplication].keyWindow;
    }
   
    CGSize  size = [self.text   sizeWithFont:self.font maxW:view.width -60];
    self.frame = CGRectMake(0, 0, 40+size.width, size.height+20);
    self.center = CGPointMake(view.width/2, view.height/2);
    [view addSubview:self];
     self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView  animateWithDuration:0.2 animations:^{
        
   self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    self.alpha = 0.7;
    } completion:^(BOOL finished) {
        if (time) {
              [self  performSelector:@selector(dismiss) withObject:nil afterDelay:time];
        }
    
    }];
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super  initWithFrame:CGRectZero];
    
    if (self) {
        self.font = [UIFont   systemFontOfSize:16];
        self.textColor = [UIColor  whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor  blackColor];
        self.alpha= .7;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.numberOfLines = 0;
    }
    return self;
}

-(void)dismiss{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView  animateWithDuration:0.1 animations:^{
            self.transform = CGAffineTransformMakeScale(0.5, 0.5);
            self.alpha = 0.2;
        } completion:^(BOOL finished) {
            [self  removeFromSuperview];
        }];
         
    });
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
    if (self.target && [self.target  respondsToSelector:self.action]) {
     
        [self.target  performSelector:self.action withObject:self];
       
    }
}

-(void)addTarget:(id)target action:(SEL)action{
    self.target = target;
    self.action = action;
}
@end
