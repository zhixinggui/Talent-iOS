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
#import "ZZInfoDetailVC.h"
#import "ZZBaseUser.h"
#import "ZZHomeViewController.h"
#import "ASScroll.h"
#import "ZZSdWebImageTool.h"
#define HeadWidth  (ScreenWidth)
#define HeadHeight  (ScreenWidth/2)
#define Height  ((HeadWidth/2 - ZZEdgeMargin)*0.5)
static  NSString *cellIden = @"collectionCell";
@interface ZZTableHeadView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)ASScroll *adScrollView;

@property (nonatomic, strong)UICollectionView *collectionView;
@end
@implementation ZZTableHeadView

-(void)setImages:(NSArray *)images{
    _adScrollView = nil;
    if (self.images == nil && images) {
        self.height += HeadHeight/2;
        self.adScrollView.hidden = NO;
    }
    
//    if (self.images  && images == nil) {
//        self.height -= HeadHeight/2;
//        self.adScrollView.hidden = YES;
//    }
    _images = images;
    NSUInteger count = images.count;
    NSMutableArray*  viewsArray = [NSMutableArray  arrayWithCapacity:count];
    for ( int i = 0; i<count; i++) {
        UIImageView*  imageView = [[UIImageView  alloc]init];
        imageView.userInteractionEnabled = YES;
    
        [imageView  setPictureImageWithURL:images[i]];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adJump:)];
        imageView.tag = i;
        [imageView addGestureRecognizer:tapGesture];
        [viewsArray  addObject:imageView];
    }
    self.adScrollView.userInteractionEnabled = YES;
    [self.adScrollView  setArrOfImages:viewsArray];

    
}

-(void)setTalents:(NSArray *)talents{
    if (self.talents == nil &&talents.count) {
        self.height += HeadHeight/2;
        self.collectionView.hidden = NO;
    }
    if (self.talents && talents == nil) {
        self.height -= HeadHeight/2;
        self.collectionView.hidden = YES;
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
    cell.otherUser = self.talents[indexPath.row];
    [cell  setNeedsLayout];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZInfoDetailVC *infoDvc = [[ZZInfoDetailVC alloc]init];
    ZZBaseUser *baseUser = self.talents[indexPath.item];
    infoDvc.userAttentionId = baseUser.userId;
    infoDvc.isEredar = baseUser.isEredar;
    [self.delegateVC.navigationController pushViewController:infoDvc animated:YES ];
}
#pragma mark - lazyOut
-(ASScroll *)adScrollView{
    if (_adScrollView == nil) {
        //广告位滚动图片
        _adScrollView = [[ASScroll alloc]initWithFrame:CGRectMake(0, 0,HeadWidth, Height)];
//        _adScrollView.scrollsToTop = NO;
        // ,@"weibo_50x50"
//        _adScrollView.imageNameArray = self.images;
//        _adScrollView.PageControlShowStyle = UIPageControlShowStyleRight;
//        _adScrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//        _adScrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
        [self addSubview:_adScrollView];
    }
    return _adScrollView;
}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        CGFloat margin = 5;
        CGFloat separ = 16.5;
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

#pragma mark -response
- (void)adJump:(UITapGestureRecognizer *)tap{
    
}
@end
