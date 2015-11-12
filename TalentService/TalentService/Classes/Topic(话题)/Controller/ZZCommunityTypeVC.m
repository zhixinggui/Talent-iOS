//
//  ZZCommunityTypeVC.m
//  TalentService
//
//  Created by charles on 15/11/3.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZCommunityTypeVC.h"
#import "ZZCommunityCollectionViewCell.h"
#import "ZZTopicHtttpTool.h"
@interface ZZCommunityTypeVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *communityCv;
@property (nonatomic, strong) NSArray *topicTypeArray;
@end

@implementation ZZCommunityTypeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getNetDataWithTopicType];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部话题";
    self.communityCv.dataSource=self;
    self.communityCv.delegate=self;
    [self.communityCv setBackgroundColor:[UIColor clearColor]];
    
}

#pragma mark ------- getNetData -------
/**话题类型请求*/
- (void)getNetDataWithTopicType {
    [ZZTopicHtttpTool topicTypesSuccess:^(NSArray *topicTypes, ZZNetDataType netDataType) {
        if (topicTypes) {
            self.topicTypeArray = topicTypes;
            [self.communityCv reloadData];
        }
    } failure:^(NSString *error, ZZNetDataType dataType) {
        
    }];
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
    return self.topicTypeArray.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UINib *nib = [UINib nibWithNibName:@"ZZCommunityCollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:communityCollectionViewCellCelldentifier];
    ZZCommunityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:communityCollectionViewCellCelldentifier forIndexPath:indexPath];
    cell.topicType = self.topicTypeArray[indexPath.item];
    ZZLog(@"cell.topicType:%@",cell.topicType);
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
    ZZLog(@"%ld",(long)indexPath.item);
    ZZTopicType *topicType = self.topicTypeArray[indexPath.item];
    [self.delegate getTopicType:topicType];
    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark -getters and setters

- (NSArray *)topicTypeArray {
    if (!_topicTypeArray) {
        _topicTypeArray = [NSArray array];
    }
    return _topicTypeArray;
}

@end
