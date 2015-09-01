//
//  ZZDetailFunctionView.m
//  TalentService
//
//  Created by zhizhen on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZDetailFunctionView.h"

@interface ZZDetailFunctionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *grayBackView;

@end
@implementation ZZDetailFunctionView
+ (instancetype)detailFunctionView{
    ZZDetailFunctionView *detailFunctionView = [[[NSBundle mainBundle]loadNibNamed:@"ZZDetailFunctionView" owner:nil options:nil]lastObject];
    return detailFunctionView;
}

- (void)awakeFromNib{
    self.frame = [UIScreen  mainScreen].bounds;
     [self.collectionView  registerClass:[UICollectionViewCell  class] forCellWithReuseIdentifier:@"cell"];
}
#pragma mark -UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor  redColor];
    
    return cell;
}


- (void)showAnimation{
    [[UIApplication  sharedApplication].keyWindow.rootViewController.view  addSubview:self];
    self.grayBackView.y = ScreenHeight + self.grayBackView.height;
    [UIView  animateWithDuration:1.5 animations:^{
        self.grayBackView.y = ScreenHeight - self.grayBackView.height;
    }];
}
@end
