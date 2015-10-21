//
//  ZZSlideDemo.m
//  SliderDemo
//
//  Created by zhizhen on 15/9/25.
//  Copyright © 2015年 zhizhen. All rights reserved.
//


#import "ZZSlideDemo.h"
@interface ZZTitleLable : UILabel
@property (nonatomic,assign) CGFloat scale;

@end


@interface ZZSlideDemo ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *topScrollView;
@property (nonatomic, strong)UIScrollView *bottmScroolView;
@property (nonatomic, strong)NSMutableArray *titleLabels;
@end
@implementation ZZSlideDemo


-(void)setFrame:(CGRect)frame{
    [super  setFrame:frame];
    
    CGFloat topHeight = 40;
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    self.topScrollView.frame = CGRectMake(0, 0, width, topHeight);
    self.bottmScroolView.frame = CGRectMake(0, CGRectGetMaxY(self.topScrollView.frame), width, height - CGRectGetMaxY(self.topScrollView.frame));
  
}

-(UIScrollView *)topScrollView{
    if (_topScrollView == nil) {
        _topScrollView = [[UIScrollView  alloc]init];
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.showsVerticalScrollIndicator = NO;
       // _topScrollView.backgroundColor = [UIColor  redColor];
        [self  addSubview:_topScrollView];
    }
    return _topScrollView;
}

-(UIScrollView *)bottmScroolView{
    if (_bottmScroolView == nil) {
        _bottmScroolView = [[UIScrollView  alloc]init];
        _bottmScroolView.showsHorizontalScrollIndicator = NO;
        _bottmScroolView.showsVerticalScrollIndicator = NO;
        _bottmScroolView.delegate = self;
        _bottmScroolView.pagingEnabled = YES;
        _bottmScroolView.bounces = NO;
        [self  addSubview:_bottmScroolView];
    }
    return _bottmScroolView;
}
-(NSMutableArray *)titleLabels{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

-(void)setConViews:(NSArray *)conViews{
    _conViews = conViews;
    NSInteger count = conViews.count;
    CGFloat lblW = self.topScrollView.frame.size.width/count;
    CGFloat lblH = self.topScrollView.frame.size.height;
    CGFloat lblY = 0;
    for (int i = 0; i<count; i++) {

        CGFloat lblX = i * lblW;
        ZZTitleLable *label = [[ZZTitleLable alloc]init];
        UIViewController *vc = conViews[i];
        label.text =vc.title;
        label.frame = CGRectMake(lblX, lblY, lblW, lblH);
    //    label.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [self.topScrollView addSubview:label];
        label.tag = i;
        if (i == 0) {//默认
            label.scale = 1.0;
        }
        label.userInteractionEnabled = YES;
       [self.titleLabels addObject:label];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    
   self.bottmScroolView.contentSize = CGSizeMake(count * self.frame.size.width, 0);
    //默认选中一个
    [self scrollViewDidEndDecelerating:self.bottmScroolView];
   
    
};

/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    ZZTitleLable *titlelable = (ZZTitleLable *)recognizer.view;
    
    CGFloat offsetX = titlelable.tag * self.bottmScroolView.frame.size.width;
    
    CGFloat offsetY = self.bottmScroolView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bottmScroolView setContentOffset:offset animated:YES];
    
    
}


#pragma mark - ******************** scrollView代理方法

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bottmScroolView.frame.size.width;
    
//    // 滚动标题栏
//    ZZTitleLable *titleLable = (ZZTitleLable *)self.topScrollView.subviews[index];
//    
//    CGFloat offsetx = titleLable.center.x - self.topScrollView.frame.size.width * 0.5;
//    
//    CGFloat offsetMax = self.topScrollView.contentSize.width - self.topScrollView.frame.size.width;
//    if (offsetx < 0) {
//        offsetx = 0;
//    }else if (offsetx > offsetMax){
//        offsetx = offsetMax;
//    }
//    
//    CGPoint offset = CGPointMake(offsetx, self.topScrollView.contentOffset.y);
//    [self.topScrollView setContentOffset:offset animated:YES];
    // 添加控制器
    UIViewController *newsVc = self.conViews[index];

    [self.titleLabels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != index) {
            ZZTitleLable *temlabel = self.titleLabels[idx];
            
            temlabel.scale = 0.0;
        }
    }];
    if (newsVc.view.superview) return;
    newsVc.view.frame = scrollView.bounds;
    [self.bottmScroolView addSubview:newsVc.view];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    ZZTitleLable *labelLeft = self.titleLabels[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.topScrollView.subviews.count) {
        ZZTitleLable *labelRight = self.titleLabels[rightIndex];

        labelRight.scale = scaleRight;
    }
    
}

@end

@implementation ZZTitleLable


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:18];
        self.scale = 0.0;
    }
    return self;
}

/** 通过scale的改变改变多种参数 */
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1];
    
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}
@end


