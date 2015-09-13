//
//  ZZApplyVC.m
//  TalentService
//
//  Created by zhizhen on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//
static  NSUInteger  const ImageCount = 5;
#import "ZZApplyVC.h"
#import "ZZTextView.h"
#import "ZZTextField.h"
#import "ZZAddImageCell.h"
#import "ZZLayerButton.h"
#import "UUPhotoActionSheet.h"
#import "UUPhotoBrowserViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "ZZApplyTalentParam.h"
#import "ZZCacheTool.h"
@interface ZZApplyVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UUPhotoActionSheetDelegate,UUPhotoBrowserDelegate,UIGestureRecognizerDelegate,ZZAddImageCellDelegate>


/** 背景scrollView*/
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;
/** 图片数量*/
@property (weak, nonatomic) IBOutlet UILabel *imageCountLabel;

/** 选择图片*/
@property (nonatomic, strong) UUPhotoActionSheet *sheet;
/** 真实姓名*/
@property (weak, nonatomic) IBOutlet ZZTextField *nameTF;
/** 身份证号*/
@property (weak, nonatomic) IBOutlet ZZTextField *idCardTF;
/** 电话号码*/
@property (weak, nonatomic) IBOutlet ZZTextField *phoneTF;
/** 验证码*/
@property (weak, nonatomic) IBOutlet ZZTextField *identifyTF;
/** 达人类型*/
@property (weak, nonatomic) IBOutlet ZZTextField *talentTypeTF;
/** 个人简介*/
@property (weak, nonatomic) IBOutlet ZZTextView *personTF;
/** 上传图片*/
@property (weak, nonatomic) IBOutlet UICollectionView *addImageCV;
/** 图片数组*/
@property (strong, nonatomic) NSMutableArray *images;
/** 点击那个进入了选片选择*/
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet ZZSecurityButton *securityButton;

@end

@implementation ZZApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"达人申请";
    self.view.backgroundColor = ZZViewBackColor;
    [self  setItem];
    [self  setChilds];
}
- (void)setItem{
    UIBarButtonItem *rightBItem = [[UIBarButtonItem  alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(commitAction)];
    self.navigationItem.rightBarButtonItem = rightBItem;
    
    self.navigationController.navigationItem.leftBarButtonItems = [UIBarButtonItem  backItemWithTarget:self action:@selector(back)];
}

- (void)setChilds{
    [self.nameTF addLeftViewImageString:@"user_30x30"];
    [self.idCardTF addLeftViewImageString:@"IDcard_40x40"];
     [self.phoneTF addLeftViewImageString:@"phone_30x30"];
     [self.identifyTF addLeftViewImageString:@"message_30x30"];
     [self.talentTypeTF addLeftViewImageString:@"mengbao_40x40"];
    self.personTF.placeholder = @"个人简介,150字以内";
    self.personTF.textContentLength = 300;
    self.securityButton.backgroundColor = LoginButtonColor;
    [self.addImageCV  registerNib:[UINib  nibWithNibName:@"ZZAddImageCell" bundle:[NSBundle  mainBundle]] forCellWithReuseIdentifier:[ZZAddImageCell  addImageCellIdentifier]];
  

}

- (void)back{
    ZZApplyTalentParam *applyParam = [[ZZApplyTalentParam  alloc]init];
    applyParam.userName = self.nameTF.text;
    applyParam.identityCard = self.idCardTF.text;
    applyParam.phone = self.phoneTF.text;
    applyParam.userPresentation = self.personTF.text;
    applyParam.eredarType = @(1);
    [ZZCacheTool saveApplyTalentParam:applyParam];
    
    [self.navigationController  popViewControllerAnimated:YES];
}
#pragma mark - private  methods
- (IBAction)securityButton:(ZZLayerButton *)sender {
    [sender  startWithSecond:ZZSecerityTime];
}

- (void)updateImageCountLabelText{
    if (self.images.count == 0) {
        self.imageCountLabel.text = [NSString  stringWithFormat:@"可选择%d张图片",ImageCount];
    }else{
        self.imageCountLabel.text = [NSString stringWithFormat:@"已选%ld张，还可添加%ld张",self.images.count,ImageCount-self.images.count];
    }
}
#pragma mark - event response
- (void)securityButtonAction{
    
}
- (IBAction)endEdit:(UITapGestureRecognizer *)sender {
    [self.backScrollView  endEditing:YES];
}


- (void)commitAction{
    
}
- (IBAction)talentKonwAction:(id)sender {

}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    [self  updateImageCountLabelText];
    return self.images.count <ImageCount ?self.images.count+1:self.images.count ;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZAddImageCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:[ZZAddImageCell  addImageCellIdentifier] forIndexPath:indexPath];
    cell.delegate = self;
    if (self.images.count == indexPath.row) {
        cell.image = nil;
    }else{
        cell.image = self.images[indexPath.row];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.images.count ) {//添加图片
        self.sheet.maxSelected = ImageCount - self.images.count;
        [self.sheet showAnimation];
    }else{//浏览已经添加的图片
        self.indexPath = indexPath;
        UUPhotoBrowserViewController *controller;
        controller = [[UUPhotoBrowserViewController alloc] init];
        controller.delegate = self;
        controller.canDelete = YES;
//        UINavigationController *naviController;
//        naviController = [[UINavigationController alloc] initWithRootViewController:controller];
//        //[self  presentViewController:naviController animated:YES completion:nil];
        [self.navigationController  pushViewController:controller animated:YES];
    }
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (self.images.count) {
        return UIEdgeInsetsZero;
    }else{
        UICollectionViewFlowLayout *currentFlowLayout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
        CGFloat  width = (collectionView.frame.size.width -  currentFlowLayout.itemSize.width)/2;
        return UIEdgeInsetsMake(0, width, 0, 0);
    }
}
#pragma mark – *****************  UIGestureRecognizerDelegate  *****************
//手势实现方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 输出点击的view的类名
    //NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark -ZZAddImageCellDelegate
-(void)addImageCellDelete:(ZZAddImageCell *)addImageCell{
    NSIndexPath *indexpath = [self.addImageCV  indexPathForCell:addImageCell];
    [self.images  removeObjectAtIndex:indexpath.item];
    [self.addImageCV  reloadData];
}
#pragma mark -UUPhotoActionSheetDelegate
- (void)actionSheetDidFinished:(NSArray *)obj{
    [self.images  addObjectsFromArray:obj];
    [self.addImageCV  reloadData];
}

#pragma mark -UUPhotoActionSheetDelegate
- (UIImage *)displayImageWithIndex:(NSInteger)index fromPhotoBrowser:(UUPhotoBrowserViewController *)browser{
    UIImage  *image = self.images[index];
    return image;
}

- (NSInteger)numberOfPhotosFromPhotoBrowser:(UUPhotoBrowserViewController *)browser{
    return self.images.count;
}

- (NSInteger)jumpIndexFromPhotoBrowser:(UUPhotoBrowserViewController *)browser{
    return self.indexPath.row;
}

-(void)deleteIndex:(NSUInteger)index fromPhotoBrowser:(UUPhotoBrowserViewController *)browser{
    [self.images  removeObjectAtIndex:index];
    [self.addImageCV  reloadData];
}
#pragma mark -lazy load
-(NSMutableArray *)images{
    if (_images == nil) {
        _images = [NSMutableArray  array];
    }
    return _images;
}

-(UUPhotoActionSheet *)sheet{
    if (_sheet == nil) {
        _sheet = [[UUPhotoActionSheet alloc] initWithWeakSuper:self];
        _sheet.delegate = self;
    }
    return _sheet;
}


-(void)dealloc{
    [self.securityButton  clearButton];
    ZZLog(@"%@",[self  class]);
}
@end
