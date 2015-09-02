//
//  ZZDetailFunctionView.m
//  TalentService
//
//  Created by zhizhen on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

NSTimeInterval const animationTime = 0.25;
CGFloat  const ViewAlpha = 0.4;
#import "ZZDetailFunctionView.h"
#import "ZZFunctionCell.h"
@interface ZZDetailFunctionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *functionCV;
@property (weak, nonatomic) IBOutlet UIView *translucentView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *grayBackView;
@property (weak, nonatomic) IBOutlet UIView *separLine;
@property (weak, nonatomic) IBOutlet UIButton *cancellButton;

@end
@implementation ZZDetailFunctionView
+ (instancetype)detailFunctionView{
    ZZDetailFunctionView *detailFunctionView = [[[NSBundle mainBundle]loadNibNamed:@"ZZDetailFunctionView" owner:nil options:nil]lastObject];
    return detailFunctionView;
}

- (void)awakeFromNib{
    self.frame = [UIScreen  mainScreen].bounds;
    [self.collectionView  registerNib:[UINib  nibWithNibName:@"ZZFunctionCell" bundle:[NSBundle  mainBundle]] forCellWithReuseIdentifier:[ZZFunctionCell  functionCellIdentifier]];
     [self.functionCV  registerNib:[UINib  nibWithNibName:@"ZZFunctionCell" bundle:[NSBundle  mainBundle]] forCellWithReuseIdentifier:[ZZFunctionCell  functionCellIdentifier]];
    self.grayBackView.backgroundColor = ZZRGBCloor(217, 217, 217);
    self.separLine.backgroundColor = ZZRGBCloor(207, 202, 198);
    [self.cancellButton  setTitleColor:ZZLightGrayColor forState:UIControlStateNormal];
}

#pragma mark -响应事件
- (IBAction)cancellButtonAction:(UIButton *)sender {
    [self dismissAnimation];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self  dismissAnimation];
}
#pragma mark -UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.collectionView) {
        return self.shares.count;
    }else{
        return self.functions.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZFunctionCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:[ZZFunctionCell  functionCellIdentifier] forIndexPath:indexPath];
    if (collectionView == self.collectionView) {
       cell.showRule = self.shares[indexPath.item];
    }else{
      cell.showRule = self.functions[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
  
    if (collectionView == self.collectionView) {
        if ([self.delegate  respondsToSelector:@selector(detailFunctionView:shares:selectedAtIndex:)]) {
            [self.delegate  detailFunctionView:self shares:self.shares selectedAtIndex:indexPath.item];
        }
    }else{
        if ([self.delegate  respondsToSelector:@selector(detailFunctionView:functions:selectedAtIndex:)]) {
            [self.delegate  detailFunctionView:self functions:self.functions selectedAtIndex:indexPath.item];
        }
    }
      [self  dismissAnimation];
}
#pragma mark -共有方法
- (void)showAnimation{
    [[UIApplication  sharedApplication].keyWindow.rootViewController.view  addSubview:self];
    self.translucentView.alpha = 0;
    self.grayBackView.y = ScreenHeight + self.grayBackView.height;
    [UIView  animateWithDuration:animationTime animations:^{
        self.translucentView.alpha = ViewAlpha;
        self.grayBackView.y = ScreenHeight - self.grayBackView.height;
    }];
    
    
}

- (void)dismissAnimation{
    [UIView animateWithDuration:animationTime animations:^{
        self.translucentView.alpha = 0;
        self.grayBackView.y = ScreenHeight + self.grayBackView.height;
    } completion:^(BOOL finished) {
        [self  removeFromSuperview];
    }];
}

-(void)dealloc{
    ZZLog(@",,%@",[self class]);
}
@end
