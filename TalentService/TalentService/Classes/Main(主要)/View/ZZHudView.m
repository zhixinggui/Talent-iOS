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
@property (nonatomic) CGSize contentSize;
@end
@implementation ZZHudView
+ (ZZHudView *)showMessage:(NSString *)message animated:(BOOL)animated{
  
    ZZHudView *hudView = [[ZZHudView  alloc]init];
    hudView.text = message;
    CGSize  size = [message   sizeWithAttributes:[NSDictionary dictionaryWithObject:hudView.font forKey:NSFontAttributeName]];
    if (size.width>260) {
        size.width=260;
    }
    hudView.contentSize = size;
    [hudView  showAnimated:YES];
    return hudView;
    
}
-(void)setFrame:(CGRect)frame{
  
    [super  setFrame:frame];
    UIWindow *keyWindow = [UIApplication  sharedApplication].keyWindow;
    self.center = keyWindow.center;
    
}
- (void)showAnimated:(BOOL)animated{

    
   
  
    self.frame = CGRectMake(0, 0, self.contentSize.width+Minwidth, 20+Minheight);
    UIWindow *keyWindow = [UIApplication  sharedApplication].keyWindow;
  
    [keyWindow  addSubview:self];
    [UIView  animateWithDuration:0.2 animations:^{
        
   
    self.alpha = 0.7;
    } completion:^(BOOL finished) {
      [self  performSelector:@selector(dismiss) withObject:nil afterDelay:2];
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
        
        self.layer.masksToBounds = YES;
    }
    return self;
}

-(void)dismiss{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView  animateWithDuration:0.1 animations:^{
            self.alpha = 0.2;
        } completion:^(BOOL finished) {
            [self  removeFromSuperview];
        }];
         
    });
}


@end
