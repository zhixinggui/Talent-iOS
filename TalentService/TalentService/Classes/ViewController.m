//
//  ViewController.m
//  TalentService
//
//  Created by zhizhen on 15/7/24.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ViewController.h"
#import "ZZSecurityButton.h"
#import "ZZTextField.h"
#import "ZZTextView.h"
#import "UUPhotoActionSheet.h"
#import "UUPhotoBrowserViewController.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UUPhotoBrowserDelegate,UUPhotoActionSheetDelegate>
@property (nonatomic, strong) ZZSecurityButton *btn;
@property (nonatomic, strong) UUPhotoActionSheet *sheet;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *array ;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation ViewController
static  NSString *inden = @",,,,,,";
-(NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray  array];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@",,,%@",[ZZAppSystem  appBundle]);
    ZZSecurityButton *btn = [[ZZSecurityButton  alloc]initWithFrame:CGRectMake(100, 20, 200, 49)];
    self.btn = btn;
    btn.second = 50;
    [btn  addTarget:self action:@selector(kkkk) forControlEvents:UIControlEventTouchUpInside];
        [self.view  addSubview:btn];
    
    UIButton *btn1 = [[UIButton  alloc]initWithFrame:CGRectMake(100,70, 200, 49)];
    btn1.backgroundColor = [UIColor  redColor];
    [btn1  addTarget:self action:@selector(kkkkk) forControlEvents:UIControlEventTouchUpInside];
    btn1.exclusiveTouch = YES;
    [self.view  addSubview:btn1];
    
    UIButton *btn2 = [[UIButton  alloc]initWithFrame:CGRectMake(100, 120, 200, 49)];
    btn2.backgroundColor = [UIColor  redColor];
    [btn2  addTarget:self action:@selector(kkkkk) forControlEvents:UIControlEventTouchUpInside];
    btn2.exclusiveTouch = YES;
    [self.view  addSubview:btn2];
    
    ZZTextView *textView = [[ZZTextView  alloc]initWithFrame:CGRectMake(100, 180, 200, 50)];
    textView.textContentLength = 10000;
 //  textView.delegate = self;
    [self.view  addSubview:textView];
    ZZLog(@",,,%ld,,,,%ld",[self  unicodeLengthOfString:@"中国，，，，"],[self unicodeLengthOfString:@"mmmmm,,,,,"]);
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    UICollectionView  *collectionView = [[UICollectionView  alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(textView.frame)) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor  redColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view  addSubview:collectionView];
     [collectionView  registerClass:[UICollectionViewCell  class] forCellWithReuseIdentifier:inden];
    self.collectionView = collectionView;
    
    _sheet = [[UUPhotoActionSheet alloc] initWithWeakSuper:self];
    _sheet.delegate = self;
    _sheet.maxSelected = 10;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:inden forIndexPath:indexPath];
    UIImage *image = self.array[indexPath.row];
    cell.backgroundView = [[UIImageView  alloc]initWithImage:image];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    UUPhotoBrowserViewController *controller;
    controller = [[UUPhotoBrowserViewController alloc] init];
    controller.delegate = self;
    controller.canDelete = YES;
    UINavigationController *naviController;
    naviController = [[UINavigationController alloc] initWithRootViewController:controller];
    //[self  presentViewController:naviController animated:YES completion:nil];
    [self  presentViewController:naviController animated:YES completion:nil];
}

- (UIImage *)displayImageWithIndex:(NSInteger)index fromPhotoBrowser:(UUPhotoBrowserViewController *)browser{
    UIImage  *image = self.array[index];
    return image;
}

- (NSInteger)numberOfPhotosFromPhotoBrowser:(UUPhotoBrowserViewController *)browser{
    return self.array.count;
}

- (NSInteger)jumpIndexFromPhotoBrowser:(UUPhotoBrowserViewController *)browser{
    return self.indexPath.row;
}

-(void)deleteIndex:(NSUInteger)index fromPhotoBrowser:(UUPhotoBrowserViewController *)browser{
    [self.array  removeObjectAtIndex:index];
    [self.collectionView  reloadData];
}

- (void)actionSheetDidFinished:(NSArray *)obj{
    [self.array  addObjectsFromArray:obj];
    [self.collectionView  reloadData];
}

- (void)kkkk {

}

- (void)kkkkk {
    [_sheet showAnimation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSUInteger) unicodeLengthOfString: (NSString *) text
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2) {
        unicodeLength++;
    }
    return unicodeLength;
}
@end
