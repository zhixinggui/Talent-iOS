//
//  ZZPublishTopicVC.m
//  TalentService
//
//  Created by zhizhen on 15/10/18.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZPublishTopicVC.h"
#import "ZZTextView.h"
#import "ZZTopicImageCell.h"
#import "ZZTopicAddImageCell.h"
#import "UUPhotoActionSheet.h"
#import "UUPhotoBrowserViewController.h"
#import "ZZUploadImageModel.h"
#import "ZZPopMenu.h"
#import "ZZIQKeyBoardTool.h"
//#import "IQUIView+Hierarchy.h"

#define CELLWIDTH  90.0
#define CELLSPACWIDTH  10.0
static  NSUInteger  const TopicImageCount = 10;
@interface ZZPublishTopicVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UUPhotoActionSheetDelegate,UUPhotoBrowserDelegate,ZZPopMenuDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet ZZTextView *contentTV;
@property (weak, nonatomic) IBOutlet UITextField *titleTf;
@property (weak, nonatomic) IBOutlet UITextField *typeTF;
@property (weak, nonatomic) IBOutlet UIButton *selectTypeButton;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCV;
@property (weak, nonatomic) IBOutlet ZZTextView *descTV;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;
@property (weak, nonatomic) IBOutlet UIScrollView *backScroView;

@property (nonatomic, strong)ZZPopMenu *popMenu;
/** 图片数组*/
@property (nonatomic, strong) NSMutableArray *images;

/** 选中的图片记录文字*/
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/** 放大选中的坐标*/
@property (nonatomic, assign) NSInteger amplificIndex;
@end

@implementation ZZPublishTopicVC
static NSString* cellIden = @"ZZPublishTopicVC";
static NSString* addCellIden = @"ZZPublishAddTopicVC";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建话题";
    [self.imageCV  registerNib:[UINib  nibWithNibName:@"ZZTopicImageCell" bundle:nil] forCellWithReuseIdentifier:cellIden];
    [self.imageCV  registerNib:[UINib  nibWithNibName:@"ZZTopicAddImageCell" bundle:nil] forCellWithReuseIdentifier:addCellIden];
    [self  setInterface];
}

- (void)setInterface{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //标题输入框
    self.titleTf.leftView = [self  getLeftOrRightView];
    self.titleTf.leftViewMode =UITextFieldViewModeAlways;

    self.titleTf.rightView = [self  getLeftOrRightView];
    self.titleTf.rightViewMode = UITextFieldViewModeAlways;
    //类型选择框
    
//    self.typeTF.rightView = self.selectTypeButton;
//    self.typeTF.rightViewMode =  UITextFieldViewModeAlways;
   // self.typeTF.isAskingCanBecomeFirstResponder = YES;
    self.typeTF.leftView = [self  getLeftOrRightView];
    self.typeTF.leftViewMode = UITextFieldViewModeAlways;
    //内容输入框
    self.contentTV.placeholder = @"请输入内容，不超过500个汉字";
    self.contentTV.textContentLength = 1000;
    //图片说明输入框
    self.descTV.placeholder = @"请输入图片说明，不超过150个汉字";
    self.descTV.textContentLength = 300;
    self.descTV.layer.borderColor = [UIColor  colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
    self.descTV.layer.borderWidth = 0.5;
    self.descTV.layer.masksToBounds = YES;
    self.descTV.layer.cornerRadius = 5;
    //发布按钮
    self.publishButton.backgroundColor = ZZNatiBarColor;
    self.publishButton.layer.cornerRadius = self.publishButton.height/2;
    self.publishButton.layer.masksToBounds = YES;
    //图片选择
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout  alloc]init];
    flowLayout.minimumInteritemSpacing = CELLSPACWIDTH;
    flowLayout.minimumLineSpacing =CELLSPACWIDTH;
    flowLayout.scrollDirection  = UICollectionViewScrollDirectionHorizontal;
    CGFloat collHeight = self.imageCV.height;
    flowLayout.itemSize = CGSizeMake(CELLWIDTH, collHeight);
    self.imageCV.collectionViewLayout = flowLayout;
}

- (UIView *)getLeftOrRightView{
    return  [[UIView  alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
}

#pragma mark - private methods
- (void)defaultSelectdIndexPath{
    if (self.images.count == 0) {
        self.selectedIndexPath = nil;
        return;
    }
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:self.images.count-1 inSection:0];
    [self  collectionView:self.imageCV  didSelectItemAtIndexPath:indexpath];
}
//发布按钮响应事件
- (IBAction)publishButtonAction:(UIButton *)sender {
    self.selectedIndexPath = self.selectedIndexPath;//确保后最后一个tupian的文字说明保存下来
  
}
- (IBAction)selectTopicType:(UIButton *)sender {
    [self.view  endEditing:YES];
    sender.selected = YES;
    [self.popMenu  showFrom:sender];
}

#pragma mark -UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.images.count == TopicImageCount ? 1 : 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return section  ? 1 : self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {//添加图片
        ZZTopicAddImageCell* cell = [collectionView  dequeueReusableCellWithReuseIdentifier:addCellIden forIndexPath:indexPath];
      
        return cell;
    }else{
        ZZTopicImageCell* cell = [collectionView  dequeueReusableCellWithReuseIdentifier:cellIden forIndexPath:indexPath];
        cell.delegate = self;
        ZZUploadImageModel *model = self.images[indexPath.item];
        cell.showIV.image = model.image;
   
            cell.arrowIV.hidden = !model.selected;
      
        return cell;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        
        UUPhotoActionSheet *sheet= [[UUPhotoActionSheet alloc] initWithWeakSuper:self];
        sheet.delegate = self;
        sheet.maxSelected = TopicImageCount - self.images.count;
        [sheet  showAnimation];
        
    }else{
        self.selectedIndexPath = indexPath;
        [self.imageCV  reloadData];
        
    }
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    CGFloat left = self.images.count ? (section ? 20 : 0):(ScreenWidth - CELLWIDTH - CELLSPACWIDTH)/4;

    return UIEdgeInsetsMake(0, left, 0, 0);
}



#pragma mark - ZZTopicImageCell
- (void)deleteImage:(ZZTopicImageCell *)cell{
    NSIndexPath *indexpath = [self.imageCV  indexPathForCell:cell];
    [self  deleteIndex:indexpath.item fromPhotoBrowser:nil];

}

- (void)amplificImage:(ZZTopicImageCell *)cell{
     NSIndexPath *indexpath = [self.imageCV  indexPathForCell:cell];
    
    self.amplificIndex = indexpath.item;
    UUPhotoBrowserViewController *controller;
    controller = [[UUPhotoBrowserViewController alloc] init];
    controller.delegate = self;
    controller.canDelete = YES;
    
    [self.navigationController  pushViewController:controller animated:YES];
}
//默认选中图片数组最后一个
#pragma mark -UUPhotoActionSheetDelegate
- (void)actionSheetDidFinished:(NSArray *)obj{
    [self.images  addObjectsFromArray:obj];
    [self.imageCV  reloadData];
    //默认选中一个
    [self  defaultSelectdIndexPath];
   
}

#pragma mark -UUPhotoActionSheetDelegate
- (UIImage *)displayImageWithIndex:(NSInteger)index fromPhotoBrowser:(UUPhotoBrowserViewController *)browser{
    ZZUploadImageModel *imageModel = self.images[index];
    UIImage  *image = [imageModel  uploadFullScreenImage];
    return image;
}

- (NSInteger)numberOfPhotosFromPhotoBrowser:(UUPhotoBrowserViewController *)browser{
    return self.images.count;
}

- (NSInteger)jumpIndexFromPhotoBrowser:(UUPhotoBrowserViewController *)browser{
    return self.amplificIndex;
}
//查看大图时，删除某张图片
-(void)deleteIndex:(NSUInteger)index fromPhotoBrowser:(UUPhotoBrowserViewController *)browser{
    [self.images  removeObjectAtIndex:index];
    [self.imageCV  reloadData];
    
    if (index == self.selectedIndexPath.item) {
        [self defaultSelectdIndexPath];
    }else if (index > self.selectedIndexPath.item){
        
    }else{
        _selectedIndexPath = [NSIndexPath indexPathForItem:self.selectedIndexPath.item-1 inSection:0];
    }
}

#pragma mark -ZZPopMenuDelegate
-(void)popMenuDidDismissed:(ZZPopMenu *)popMenu{
    self.selectTypeButton.selected  = NO;
}
#pragma mark -UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField  isEqual:self.typeTF]) {
    
        return NO;
    }else{
        return YES;
    }
}
#pragma mark -set
-(NSMutableArray *)images{
    if (_images == nil) {
        _images = [NSMutableArray  array];
    }
    return _images;
}



-(void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath{
    if (_selectedIndexPath) {
        for (ZZUploadImageModel *model in self.images) {
            if (model.selected) {
                model.selected = NO;
                model.desc = self.descTV.text;
                 break;
            }
        }
    }
    
    _selectedIndexPath = selectedIndexPath;
    if (selectedIndexPath){
        ZZUploadImageModel *model = self.images[selectedIndexPath.item];
        self.descTV.text = model.desc ;
        model.selected = YES;
        [self.descTV  updatePlaceholderLabelStatus];
    }
    
}

-(ZZPopMenu *)popMenu{
    if (_popMenu == nil) {
        _popMenu = [[ZZPopMenu alloc]init];
        _popMenu.dimBackground = YES;
        _popMenu.delegate = self;
    }
    return _popMenu;
}
@end
