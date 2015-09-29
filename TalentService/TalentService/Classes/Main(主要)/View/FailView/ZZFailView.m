//
//  ZZFailView.m
//  TalentService
//
//  Created by zhizhen on 15/9/29.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZFailView.h"

@interface ZZImageTopButton : UIButton

@end
@interface ZZFailView ()
@property (nonatomic ,strong)ZZImageTopButton *button;
@property  (nonatomic, strong)UIImage *image;
@property (nonatomic, copy)NSString *title;
@end
@implementation ZZFailView



-(ZZImageTopButton *)button{
    if (_button == nil) {
        _button = [[ZZImageTopButton  alloc]init];
        [self  addSubview:_button];
    }
    return _button;
}
-(void)setTitle:(NSString *)title{
    _title = title;
    [self.button  setTitle:title];
    [self.button  setImage:@"talent_40x40"];
    self.button.backgroundColor = [UIColor  redColor];
    [self.button  sizeToFit];
    
  //  [self  changeButton:self.button]
}

-(void)setContentInset:(UIEdgeInsets)contentInset{
    _contentInset = contentInset;
    CGRect bounds = self.superview.bounds;
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
    
    CGFloat  top = self.contentInset.top;
    CGFloat  bottom = self.contentInset.bottom;
    CGFloat  left = self.contentInset.left;
    CGFloat  right = self.contentInset.right;
    self.frame = CGRectMake(left,top , width-left-right, height-top-bottom);
    
}
-(void)changeButton:(UIButton *)btn{
    UIButton *b = btn;
    CGPoint buttonBoundsCenter = CGPointMake(CGRectGetMidX(b.bounds), CGRectGetMidY(b.bounds));
    
    // 找出imageView最终的center
    
    CGPoint endImageViewCenter = CGPointMake(buttonBoundsCenter.x, CGRectGetMidY(b.imageView.bounds));
    
    // 找出titleLabel最终的center
    
    CGPoint endTitleLabelCenter = CGPointMake(buttonBoundsCenter.x, CGRectGetHeight(b.bounds)-CGRectGetMidY(b.titleLabel.bounds));
    
    // 取得imageView最初的center
    
    CGPoint startImageViewCenter = b.imageView.center;
    
    // 取得titleLabel最初的center
    
    CGPoint startTitleLabelCenter = b.titleLabel.center;
    
    // 设置imageEdgeInsets
    
    CGFloat imageEdgeInsetsTop = endImageViewCenter.y - startImageViewCenter.y;
    
    CGFloat imageEdgeInsetsLeft = endImageViewCenter.x - startImageViewCenter.x;
    
    CGFloat imageEdgeInsetsBottom = -imageEdgeInsetsTop;
    
    CGFloat imageEdgeInsetsRight = -imageEdgeInsetsLeft;
    
    b.imageEdgeInsets = UIEdgeInsetsMake(imageEdgeInsetsTop, imageEdgeInsetsLeft, imageEdgeInsetsBottom, imageEdgeInsetsRight);
    
    // 设置titleEdgeInsets
    
    CGFloat titleEdgeInsetsTop = endTitleLabelCenter.y-startTitleLabelCenter.y;
    
    CGFloat titleEdgeInsetsLeft = endTitleLabelCenter.x - startTitleLabelCenter.x;
    
    CGFloat titleEdgeInsetsBottom = -titleEdgeInsetsTop;
    
    CGFloat titleEdgeInsetsRight = -titleEdgeInsetsLeft;
    
    b.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeInsetsTop, titleEdgeInsetsLeft, titleEdgeInsetsBottom, titleEdgeInsetsRight);
}
-(void)layoutSubviews{
    [super  layoutSubviews];
    self.button.centerX = self.width/2;
    self.button.centerY = self.height/2;
}
+(instancetype)failViewReason:(NSString *)reason toView:(UIView *)toView{
    ZZFailView *failView = [[self  alloc]initWithFrame:toView.bounds];
    failView.title = reason;
    failView.backgroundColor = [UIColor  redColor];
    [toView  addSubview:failView];
    return failView;
}

@end

@implementation ZZImageTopButton


-(void)setFrame:(CGRect)frame{
    
   
}
-(void)layoutSubviews{
    [super  layoutSubviews];
    
   
}

@end