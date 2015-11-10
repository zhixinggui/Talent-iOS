//
//  ZZCommunityTypeVC.m
//  TalentService
//
//  Created by charles on 15/11/3.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZCommunityTypeVC.h"
#import "ZZCommunityCollectionViewCell.h"
@interface ZZCommunityTypeVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *communityCv;

@end

@implementation ZZCommunityTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部话题";
    self.communityCv.dataSource=self;
    self.communityCv.delegate=self;
    [self.communityCv setBackgroundColor:[UIColor clearColor]];
    //注册Cell，必须要有
    [self.communityCv registerClass:[ZZCommunityCollectionViewCell class] forCellWithReuseIdentifier:communityCollectionViewCellCelldentifier];
}

#pragma mark -- UICollectionViewDataSource

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UINib *nib = [UINib nibWithNibName:@"ZZCommunityCollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:communityCollectionViewCellCelldentifier];
    ZZCommunityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:communityCollectionViewCellCelldentifier forIndexPath:indexPath];
    
    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (ScreenWidth == 320) {
        return CGSizeMake(80, 40);
    }else if (ScreenWidth >375) {
        return CGSizeMake(110, 40);
    }else {
        return CGSizeMake(100, 40);
    }
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
