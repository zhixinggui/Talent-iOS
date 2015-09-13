//
//  ZZTableHeadView.m
//  TalentService
//
//  Created by zhizhen on 15/8/25.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZTableHeadView.h"
#import "AdScrollView.h"
#import "ZZSuperCell.h"
#define HeadWidth  (ScreenWidth)
#define HeadHeight  (ScreenWidth/2)
#define Height  ((HeadWidth/2 - ZZEdgeMargin)*0.5)
static  NSString *cellIden = @"collectionCell";
@interface ZZTableHeadView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)AdScrollView *adScrollView;
@property (nonatomic, strong)UICollectionView *collectionView;
@end
@implementation ZZTableHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
      
    }
    return self;
}
-(void)setImages:(NSArray *)images{
    if (self.images == nil) {
        self.height += HeadHeight/2;
        self.adScrollView.hidden = NO;
    }
    _images = images;
    self.adScrollView.imageNameArray = images;
    [self.adScrollView  setNeedsLayout];
    
}

-(void)setTalents:(NSArray *)talents{
    if (self.talents == nil) {
        self.height += HeadHeight/2;
        self.collectionView.hidden = NO;
    }
    _talents  = talents;
    [self.collectionView  reloadData];
   
}

-(void)layoutSubviews{
    [super  layoutSubviews];
    CGFloat y =0;
    if (self.images) {
        y = CGRectGetMaxY(self.adScrollView.frame);
    }
    
    if (self.talents) {
        self.collectionView.y = y;
    }
}
#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.talents.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZSuperCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:cellIden forIndexPath:indexPath];
    [cell  setNeedsLayout];
    return cell;
}
#pragma mark - lazyOut
-(AdScrollView *)adScrollView{
    if (_adScrollView == nil) {
        //广告位滚动图片
        AdScrollView * scrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(0, 0,HeadWidth, Height)];
        scrollView.scrollsToTop = NO;
        // ,@"weibo_50x50"
        scrollView.imageNameArray = @[@"QQ_50x50",@"Wechat_50x50",@"weibo_50x50"];
        scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
        scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
        scrollView.hidden = YES;
        _adScrollView = scrollView;
        [self addSubview:scrollView];
    }
    return _adScrollView;
}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        CGFloat margin = 5;
        CGFloat separ = 20;
        CGFloat itemW = 60;
        CGFloat itemH = Height - 2*margin;
        
        //collectionView  创建
        //布局
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout  alloc]init];
        flowLayout.itemSize = CGSizeMake(itemW, itemH);
        flowLayout.minimumLineSpacing = separ*2;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(margin, separ, margin, separ);
        
        UICollectionView *collectionView = [[UICollectionView  alloc]initWithFrame:CGRectMake(0, 0, HeadWidth, Height) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor  whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = NO;
        [collectionView  registerClass:[ZZSuperCell  class] forCellWithReuseIdentifier:cellIden];
        [self addSubview:collectionView];
        _collectionView = collectionView;
        collectionView.hidden = YES;
    }
    return _collectionView;
}
@end
