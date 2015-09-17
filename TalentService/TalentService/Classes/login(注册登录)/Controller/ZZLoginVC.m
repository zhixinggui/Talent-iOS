//
//  ZZLoginVC.m
//  TalentService
//
//  Created by charles on 15/8/17.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZLoginVC.h"
#import "ZZFirstLoginVC.h"
#import "ZZRegistVC.h"
#import "ZZLayerButton.h"
#import "ZZAppSystem.h"

NSTimeInterval  const timeInterval = 3;
@interface ZZLoginVC ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
/**
 *  页码
 */
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet ZZLayerButton *loginButton;

@property (weak, nonatomic) IBOutlet ZZLayerButton *resignButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong)NSArray *colorArray;
@end

@implementation ZZLoginVC
#pragma mark   life  cycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self  addTimer];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super  viewWillDisappear:animated];
    [self  removeTimer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addScrollview];
 

    /**
     *  设置button颜色
     */
    self.loginButton.backgroundColor = LoginButtonColor;
    self.loginButton.uxy_acceptEventInterval = 1;
    self.resignButton.uxy_acceptEventInterval = 1;
}

-(void)addScrollview{
    /**图片的宽*/
    CGFloat imageW = [UIScreen mainScreen].bounds.size.width;
    /**  图片的高*/
    CGFloat imageH = [UIScreen mainScreen].bounds.size.height-117;
    /**图片的Y*/
    CGFloat imageY = 0;
    /**  图片数量*/
    NSInteger totalCount = 5;
    /** 添加图片*/
    for (int i = 0; i<totalCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        /** 图片的X*/
        CGFloat imageX = i*imageW;
        /**  图片frame*/
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        /**  设置图片*/
        imageView.backgroundColor = self.colorArray[i];
        /** 隐藏指示条*/
        self.scrollview.showsHorizontalScrollIndicator = NO;
        /**  scrollview加载图片*/
        [self.scrollview addSubview:imageView];
    }
    /**设置scrollview的滚动范围*/
    CGFloat contentW = totalCount *imageW;
    /** 不允许垂直方向进行滚动*/
    self.scrollview.contentSize = CGSizeMake(contentW, 0);
    /** 设置分页*/
    self.scrollview.pagingEnabled = YES;
    /** 监听scrollview的滚动*/
    self.scrollview.delegate = self;
  
}



#pragma mark private methods
/**
 *  开启定时器
 */
- (void)addTimer{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
/**
 *  关闭定时器
 */
-(void)removeTimer{
    [self.timer invalidate];
}

//暂定定时器
- (void)pauseTimer{
    if (![self.timer isValid]) {
        return ;
    }
    [self.timer setFireDate:[NSDate  distantFuture]];
}
//开启计时器
- (void)openTimer{
    if (![self.timer isValid]) {
        return ;
    }
    [self.timer  setFireDate:[NSDate  dateWithTimeIntervalSinceNow:timeInterval]];
}
//开启定时器

-(void)nextImage{
    int page = (int)self.pageControl.currentPage;
    if (page == 4) {
        page = 0;
    }else{
        page++;
    }
    /**
     *  滚动scrollview
     */
    CGFloat x = page* self.scrollview.width;
    self.scrollview.contentOffset = CGPointMake(x, 0);
}

#pragma mark  UIScrollViewDelegate
/**
 *  scrollview滚动的时候调用
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    ZZLog(@"滚动中");
    /**
     *  计算页码
     *  页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
     */
    CGFloat scrollviewW = scrollView.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x+scrollviewW/2)/scrollviewW;
    self.pageControl.currentPage = page;
    self.scrollview.contentOffset = CGPointMake(x, 0);
}
/**
 *  开始拖拽的时候调用
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    /**
     *  暂停定时器
     */
    [self pauseTimer];
}
/**
 *  拖拽结束的时候调用
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    /**
     *  开启计时器
     */
    [self openTimer];
}

#pragma mark event response
/**
 *  登录入口
 */
- (IBAction)loginEvent:(UIButton *)sender {
    ZZLog(@"登录");
 
    ZZFirstLoginVC *firstLoginVc = [[ZZFirstLoginVC alloc]init];
    [self.navigationController pushViewController:firstLoginVc animated:YES];
  
}
/**
 *  注册入口
 */
- (IBAction)registEvent:(UIButton *)sender {
    ZZLog(@"注册");

    ZZRegistVC *registVc = [[ZZRegistVC alloc]init];
    [self.navigationController pushViewController:registVc animated:YES];
   
}


#pragma mark lazy load
-(NSArray *)colorArray{
    if (!_colorArray) {
        UIColor *redColor = [UIColor whiteColor];
        UIColor *greenColor = [UIColor greenColor];
        UIColor *purpleColor = [UIColor purpleColor];
        UIColor *yellowColor = [UIColor yellowColor];
        UIColor *blueColor = [UIColor blueColor];
        _colorArray = @[redColor,greenColor,purpleColor,yellowColor,blueColor];
    }
    return _colorArray;
}

-(void)dealloc{
   
    ZZLog(@",,,%@",[self  class]);
   
}



@end
