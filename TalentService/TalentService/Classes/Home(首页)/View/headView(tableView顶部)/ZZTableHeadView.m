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
@interface ZZTableHeadView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)AdScrollView *adScrollView;
@property (nonatomic, strong)UICollectionView *collectionView;
@end
@implementation ZZTableHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
        [self  getUpChlidViewsWithFrame:(CGRect)frame];
    }
    return self;
}
static  NSString *cellIden = @"collectionCell";
- (void)getUpChlidViewsWithFrame:(CGRect)frame{
    //广告位滚动图片
    CGFloat sx = 0;
    CGFloat sy = 0;
    CGFloat w = frame.size.width;
    CGFloat h = (frame.size.height - ZZEdgeMargin)*0.5;
    AdScrollView * scrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(sx, sy, w, h)];
    scrollView.scrollsToTop = NO;
 // ,@"weibo_50x50"
    scrollView.imageNameArray = @[@"QQ_50x50",@"Wechat_50x50",@"weibo_50x50"];
    scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    [self addSubview:scrollView];
    self.adScrollView = scrollView;
    
    //滚动的达人
    CGFloat cx = 0;
    CGFloat cy = CGRectGetMaxY(scrollView.frame);
    
    CGFloat margin = 5;
    CGFloat separ = 20;
    CGFloat itemW = 60;
    CGFloat itemH = h - 2*margin;
    
    //collectionView  创建
    //布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout  alloc]init];
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumLineSpacing = separ*2;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(margin, separ, margin, separ);
    
    UICollectionView *collectionView = [[UICollectionView  alloc]initWithFrame:CGRectMake(cx, cy, w, h) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor  whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollsToTop = NO;
    [collectionView  registerClass:[ZZSuperCell  class] forCellWithReuseIdentifier:cellIden];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 13;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZSuperCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:cellIden forIndexPath:indexPath];
    return cell;
}

@end
