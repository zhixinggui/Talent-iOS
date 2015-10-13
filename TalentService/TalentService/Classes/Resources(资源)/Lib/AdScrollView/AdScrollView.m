//
//  AdScrollView.m
//  广告循环滚动效果
//
//  Created by QzydeMac on 14/12/20.
//  Copyright (c) 2014年 Qzy. All rights reserved.
//

#import "AdScrollView.h"

#define HIGHT -10
static CGFloat const chageImageTime = 3.0;
static NSUInteger currentImage = 0;//记录中间图片的下标,开始总是为1

@interface AdScrollView ()

{
    //广告的label
    UILabel * _adLabel;
    //循环滚动的三个视图
    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;
    //循环滚动的周期时间
    NSTimer * _moveTime;
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL _isTimeUp;
    //为每一个图片添加一个广告语(可选)
    UILabel * _leftAdLabel;
    UILabel * _centerAdLabel;
    UILabel * _rightAdLabel;
}

@property (retain,nonatomic,readonly) UIImageView * leftImageView;
@property (retain,nonatomic,readonly) UIImageView * centerImageView;
@property (retain,nonatomic,readonly) UIImageView * rightImageView;

@end

@implementation AdScrollView

#pragma mark - 自由指定广告所占的frame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.delegate = self;
        
        _leftImageView = [[UIImageView alloc]init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        _leftImageView.clipsToBounds = YES;
         [self addSubview:_leftImageView];
        
        _centerImageView = [[UIImageView alloc]init];
        _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _centerImageView.userInteractionEnabled = YES;
        _centerImageView.clipsToBounds = YES;
        [self addSubview:_centerImageView];
        
        _rightImageView = [[UIImageView alloc]init];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
        _rightImageView.clipsToBounds = YES;
        [self addSubview:_rightImageView];
        
        _moveTime = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        _isTimeUp = NO;
        
    }
    return self;
}

#pragma mark - 设置广告所使用的图片(名字)
- (void)setImageNameArray:(NSArray *)imageNameArray
{
    _imageNameArray = imageNameArray;
    if (imageNameArray.count>1) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.numberOfPages = _imageNameArray.count;
        _pageControl.currentPage = 0;
        _pageControl.enabled = NO;
        [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
    }
   [self  setImageViewImages];
  
}

#pragma mark - 设置每个对应广告对应的广告语
- (void)setAdTitleArray:(NSArray *)adTitleArray withShowStyle:(AdTitleShowStyle)adTitleStyle
{
    _adTitleArray = adTitleArray;
    
    if(adTitleStyle == AdTitleShowStyleNone)
    {
        return;
    }

    
    _leftAdLabel = [[UILabel alloc]init];
    _centerAdLabel = [[UILabel alloc]init];
    _rightAdLabel = [[UILabel alloc]init];

    [_leftImageView addSubview:_leftAdLabel];
   
    [_centerImageView addSubview:_centerAdLabel];

    [_rightImageView addSubview:_rightAdLabel];
    
    if (adTitleStyle == AdTitleShowStyleLeft) {
        _leftAdLabel.textAlignment = NSTextAlignmentLeft;
        _centerAdLabel.textAlignment = NSTextAlignmentLeft;
        _rightAdLabel.textAlignment = NSTextAlignmentLeft;
    }
    else if (adTitleStyle == AdTitleShowStyleCenter)
    {
        _leftAdLabel.textAlignment = NSTextAlignmentCenter;
        _centerAdLabel.textAlignment = NSTextAlignmentCenter;
        _rightAdLabel.textAlignment = NSTextAlignmentCenter;
    }
    else
    {
        _leftAdLabel.textAlignment = NSTextAlignmentRight;
        _centerAdLabel.textAlignment = NSTextAlignmentRight;
        _rightAdLabel.textAlignment = NSTextAlignmentRight;
    }
    
    /*
    _leftAdLabel.text = _adTitleArray[0];
    _centerAdLabel.text = _adTitleArray[1];
    if (_adTitleArray.count>2) {
         _rightAdLabel.text = _adTitleArray[2];
    }
   */
    
}


#pragma mark - 创建pageControl,指定其显示样式
- (void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle
{
    if (PageControlShowStyle == UIPageControlShowStyleNone) {
        return;
    }
    _PageControlShowStyle = PageControlShowStyle;
  
}
//由于PageControl这个空间必须要添加在滚动视图的父视图上(添加在滚动视图上的话会随着图片滚动,而达不到效果)
- (void)addPageControl
{
    [[self superview] addSubview:_pageControl];
}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    [self setContentOffset:CGPointMake(self.bounds.size.width *(_imageNameArray.count > 2 ? 2:1), 0) animated:YES];
    _isTimeUp = YES;
 
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = self.bounds.size.width;
    if (self.contentOffset.x == 0)
    {
        currentImage = (currentImage-1)%_imageNameArray.count;
        _pageControl.currentPage = (_pageControl.currentPage - 1)%_imageNameArray.count;
    }
    else if(self.contentOffset.x == width*(_imageNameArray.count > 2 ? 2:1) )
    {
        
       currentImage = (currentImage+1)%_imageNameArray.count;
       _pageControl.currentPage = (_pageControl.currentPage + 1)%_imageNameArray.count;
    }
    else
    {
        return;
    }
    

    [self  setImageViewImages];
    /*
    _leftAdLabel.text = _adTitleArray[(currentImage-1)%_imageNameArray.count];
    _centerAdLabel.text = _adTitleArray[currentImage%_imageNameArray.count];
    _rightAdLabel.text = _adTitleArray[(currentImage+1)%_imageNameArray.count];
    */
    self.contentOffset = CGPointMake(width, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }
    _isTimeUp = NO;
}


-(void)layoutSubviews{
    [super  layoutSubviews];
    if (_centerImageView.frame.size.height<=0) {
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        
        self.contentOffset = CGPointMake(width, 0);
        self.contentSize = CGSizeMake(width * (_imageNameArray.count > 2 ? 3:2), height);
        _leftImageView.frame =  CGRectMake(0, 0, width, height);
        _centerImageView.frame = CGRectMake(width, 0, width, height);
        _rightImageView.frame = CGRectMake(width*2, 0, width, width);
        _leftAdLabel.frame = CGRectMake(10, height - 40, width, 20);
        
        _centerAdLabel.frame = CGRectMake(10, height - 40, width, 20);
        
        _rightAdLabel.frame = CGRectMake(10, height - 40, width, 20);
        
        if (_PageControlShowStyle == UIPageControlShowStyleLeft)
        {
            _pageControl.frame = CGRectMake(10, HIGHT+height - 20, 20*_pageControl.numberOfPages, 20);
        }
        else if (_PageControlShowStyle == UIPageControlShowStyleCenter)
        {
            _pageControl.frame = CGRectMake(0, 0, 20*_pageControl.numberOfPages, 20);
            _pageControl.center = CGPointMake(width/2.0, HIGHT+height - 10);
        }
        else
        {
            _pageControl.frame = CGRectMake( width - 20*_pageControl.numberOfPages, HIGHT+height - 20, 20*_pageControl.numberOfPages, 20);
        }
    }
  
  
}

#pragma mark -private  methods
- (void)setImageViewImages{

    switch (_imageNameArray.count) {
        case 0:
            return;
            break;
        case 1:
            [_centerImageView setPictureImageWithURL:_imageNameArray[currentImage%_imageNameArray.count]];
//              _centerImageView.image = [UIImage imageNamed:_imageNameArray[currentImage%_imageNameArray.count]];
            break;
        case 2:
            
            if (currentImage == 1) {
                [_centerImageView setPictureImageWithURL:_imageNameArray[1]];
                [_leftImageView setPictureImageWithURL:_imageNameArray[0]];
                [_rightImageView setPictureImageWithURL:_imageNameArray[0]];
                //_centerImageView.image = [UIImage imageNamed:_imageNameArray[1]];
                //_leftImageView.image = [UIImage imageNamed:_imageNameArray[0]];
                //_rightImageView.image = [UIImage imageNamed:_imageNameArray[0]];
            }else{
//                _leftImageView.image = [UIImage imageNamed:_imageNameArray[1]];
//                _rightImageView.image = [UIImage imageNamed:_imageNameArray[1]];
//                _centerImageView.image = [UIImage imageNamed:_imageNameArray[0]];
                [_centerImageView setPictureImageWithURL:_imageNameArray[0]];
                [_leftImageView setPictureImageWithURL:_imageNameArray[1]];
                [_rightImageView setPictureImageWithURL:_imageNameArray[1]];
            }
            
         
            break;
        case 3:
            [_centerImageView setPictureImageWithURL:_imageNameArray[currentImage%_imageNameArray.count]];
            [_leftImageView setPictureImageWithURL:_imageNameArray[(currentImage-1)%_imageNameArray.count]];
            [_rightImageView setPictureImageWithURL:_imageNameArray[(currentImage+1)%_imageNameArray.count]];
//            _leftImageView.image = [UIImage imageNamed:_imageNameArray[(currentImage-1)%_imageNameArray.count]];
//            _centerImageView.image = [UIImage imageNamed:_imageNameArray[currentImage%_imageNameArray.count]];
//            _rightImageView.image = [UIImage imageNamed:_imageNameArray[(currentImage+1)%_imageNameArray.count]];
        default:
            break;
    }
    
}
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
