//
//  UUPhotoBrowserViewController.m
//  UUPhotoActionSheet
//
//  Created by zhangyu on 15/7/10.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUPhotoBrowserViewController.h"
#import "UUToolBarView.h"
#import "UUZoomingScrollView.h"

#import "UUPhotoConst.h"

#define PADDING 10

@interface UUPhotoBrowserViewController() < UIScrollViewDelegate , UIAlertViewDelegate >{
    
    NSMutableSet *_visiblePages, *_recycledPages;
}
@property (nonatomic, strong, getter = getToolBarView) UUToolBarView *toolBarView;
@property (nonatomic, strong, getter = getRootScrollView) UIScrollView *rootScroller;

@property (nonatomic, strong, getter = getButtonSelected) UIButton *btnSelected;


#warning titleString
@property (nonatomic,copy) NSString *titleString;

@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UUZoomingScrollView *currentPage;
@end

@implementation UUPhotoBrowserViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    _visiblePages = [[NSMutableSet alloc] init];
    _recycledPages = [[NSMutableSet alloc] init];
    
    [self configUI];
    
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc{

    [_visiblePages removeAllObjects];
    [_recycledPages removeAllObjects];
    
    _visiblePages = nil;
    _recycledPages = nil;
}

#pragma mark - life cycle

- (void)configUI{
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    [self.view addSubview:self.rootScroller];
    if (self.canDelete == 0) {
        [self.view addSubview:self.toolBarView];
    }
    [self configBarButtonItem];
    [self updateVisiblePageView];
    if ([self jumpPage] > 0) [self jumpToPageAtIndex:[self jumpPage] animated:NO];
    if (self.navigationController.childViewControllers.count == 1) {//当是push出来的时候要自定义返回按钮
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem  alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
}


- (void)configBarButtonItem{
    UIBarButtonItem *barButton;
    if (self.canDelete) {
        barButton = [[UIBarButtonItem alloc] initWithCustomView:self.deleteButton];
    }else{
        barButton = [[UIBarButtonItem alloc] initWithCustomView:self.btnSelected];
    }
   
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)configurePage:(UUZoomingScrollView *)page forIndex:(NSUInteger)index {
    
    page.tag = index;
    page.frame = [self frameForPageAtIndex:index];
    [page displayImage:[self displayImageWithIndex:index]];
    [self isSelectedPhotoWithIndex:index];
}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        if (self.delegate  && [self.delegate respondsToSelector:@selector(deleteIndex:fromPhotoBrowser:)]) {
            [self.delegate  deleteIndex:self.currentPage.tag fromPhotoBrowser:self];
            if ([self numberOfPhotos] == 0) {
                [self.navigationController  popViewControllerAnimated:YES];
            }
            [self.currentPage  removeFromSuperview];
            
          [_visiblePages  removeObject:self.currentPage];
            [_recycledPages  removeObject:self.currentPage];
            self.currentPage = nil;
           _rootScroller.contentSize = [self contentSizeForPagingScrollView];
            [self  updateVisiblePageView];

        }
    }
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self updateVisiblePageView];
}

#pragma mark - Custom Deledate

- (BOOL)isMaxSelectedNumber{

    if (_delegate && [_delegate respondsToSelector:@selector(isCheckMaxSelectedFromPhotoBrowser:)]) {
    
        return [_delegate isCheckMaxSelectedFromPhotoBrowser:self];
    }
    
    return YES;
}

- (void)isSelectedPhotoWithIndex:(NSInteger )index{

    if (_delegate && [_delegate respondsToSelector:@selector(isSelectedPhotosWithIndex:fromPhotoBrowser:)]) {
        
        if (self.canDelete) {
            self.deleteButton.tag = index;
        }else{
              _btnSelected.tag = index;
        }
      
        
        if ([_delegate isSelectedPhotosWithIndex:index fromPhotoBrowser:self]){
        
            _btnSelected.selected = YES;
            
        }else{
        
            _btnSelected.selected = NO;
  
        }
    }
}

- (NSInteger )jumpPage{

    if (_delegate && [_delegate respondsToSelector:@selector(jumpIndexFromPhotoBrowser:)]) {
        
        return [_delegate jumpIndexFromPhotoBrowser:self];
    }
    
    return 0;
}

- (NSInteger )numberOfPhotos{
    
    if (_delegate && [_delegate respondsToSelector:@selector(numberOfPhotosFromPhotoBrowser:)]) {
        
        return [_delegate numberOfPhotosFromPhotoBrowser:self];
    }
    
    return 0;
}

- (UIImage *)displayImageWithIndex:(NSInteger )index{

    if (_delegate && [_delegate respondsToSelector:@selector(displayImageWithIndex:fromPhotoBrowser:)]) {
        
        return [_delegate displayImageWithIndex:index fromPhotoBrowser:self];
    }
    
    return nil;
}


#pragma mark - Event Response
//返回，自定义左上角 返回按钮
- (void)back{
    [self  dismissViewControllerAnimated:YES completion:nil];
}

- (void)onClickSelected:(UIButton *)sender{

    if (!sender.selected && [self isMaxSelectedNumber]) return;
    
    sender.selected = !sender.selected;
    
    if (_delegate && [_delegate respondsToSelector:@selector(displayImageWithIndex:selectedChanged:)]) {
        
        return [_delegate displayImageWithIndex:sender.tag selectedChanged:sender.selected];
    }
}

- (void)onClickImageBrowser:(UIGestureRecognizer *)gesture{
    
    [self setHideNavigationBar];
}

- (void)onClickDleted:(UIButton *)sender{
    UIAlertView *removeAlert = [[UIAlertView alloc]
                                initWithTitle:@"确定要删除此图片？"
                                message:nil
                                delegate:self
                                cancelButtonTitle:@"取消"
                                otherButtonTitles:@"确定", nil];
    [removeAlert show];
}
#pragma mark - Private Methods

- (void)updateVisiblePageView{

    CGRect visibleBounds = _rootScroller.bounds;
    NSInteger iFirstIndex = (NSInteger)floorf((CGRectGetMinX(visibleBounds)+PADDING*2) / CGRectGetWidth(visibleBounds));
    NSInteger iLastIndex  = (NSInteger)floorf((CGRectGetMaxX(visibleBounds)-PADDING*2-1) / CGRectGetWidth(visibleBounds));
    if (iFirstIndex < 0) iFirstIndex = 0;
    if (iFirstIndex > [self numberOfPhotos] - 1) iFirstIndex = [self numberOfPhotos] - 1;
    if (iLastIndex < 0) iLastIndex = 0;
    if (iLastIndex > [self numberOfPhotos] - 1) iLastIndex = [self numberOfPhotos] - 1;
    
    NSInteger pageIndex;
    for (UUZoomingScrollView *page in _visiblePages) {
        pageIndex = page.tag;
        if (pageIndex < (NSUInteger)iFirstIndex || pageIndex > (NSUInteger)iLastIndex) {
            [_recycledPages addObject:page];
            
            [page prepareForReuse];
            [page removeFromSuperview];
        }
    }
    
    [_visiblePages minusSet:_recycledPages];
    while (_recycledPages.count > 1) // Only keep 2 recycled pages
        [_recycledPages removeObject:[_recycledPages anyObject]];
    
    // Add missing pages
    for (NSUInteger index = (NSUInteger)iFirstIndex; index <= (NSUInteger)iLastIndex; index++) {
        if (![self isDisplayingPageForIndex:index]) {
            
            // Add new page
            UUZoomingScrollView *page = [self dequeueRecycledPage];
            if (!page) {
                page = [[UUZoomingScrollView alloc] init];
                [page addImageTarget:self action:@selector(onClickImageBrowser:)];
            }
            [_visiblePages addObject:page];
            [self configurePage:page forIndex:index];
            
            [_rootScroller addSubview:page];
            self.currentPage = page;
            self.titleString = [NSString  stringWithFormat:@"%ld/%ld",index+1,[self  numberOfPhotos]];
        }
    }
}

- (void)setHideNavigationBar{
    
    CGRect frame = _toolBarView.frame;
    if (self.navigationController.navigationBarHidden) {
        
        frame.origin.y = ScreenHeight -50;
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [self.navigationController setNavigationBarHidden:NO animated:YES];

        
    } else {
        
        frame.origin.y = ScreenHeight;
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
     
    }
    
    [UIView animateWithDuration:.25f animations:^{
        
        _toolBarView.frame = frame;
    }];
}

- (void)jumpToPageAtIndex:(NSUInteger)index animated:(BOOL)animated {
    
    // Change page
    NSInteger numberOfPhotos = [UUAssetManager sharedInstance].assetPhotos.count;
    if (index < numberOfPhotos) {
        
        CGRect pageFrame = [self frameForPageAtIndex:index];
        [_rootScroller setContentOffset:CGPointMake(pageFrame.origin.x - PADDING, 0) animated:animated];
    }
}

- (UUZoomingScrollView *)dequeueRecycledPage {
    
    UUZoomingScrollView *page = [_recycledPages anyObject];
    if (page) [_recycledPages removeObject:page];
    
    return page;
}

- (BOOL)isDisplayingPageForIndex:(NSUInteger)index {
    
    for (UUZoomingScrollView *page in _visiblePages){
        
        if (page.tag == index) return YES;
    }
    
    return NO;
}



- (CGRect)frameForPageAtIndex:(NSUInteger)index {
    
    CGRect bounds = _rootScroller.bounds;
    CGRect pageFrame = bounds;
    pageFrame.size.width -= (2 * PADDING);
    pageFrame.origin.x = (bounds.size.width * index) + PADDING;
    return CGRectIntegral(pageFrame);
}

- (CGRect)frameForPagingScrollView {
    
    CGRect frame = self.view.bounds;
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    return CGRectIntegral(frame);
}


- (CGSize)contentSizeForPagingScrollView {
    
    CGRect bounds = _rootScroller.bounds;
    return CGSizeMake(bounds.size.width * [self numberOfPhotos], 0);
}

#pragma mark - Getters And Setters

- (UIScrollView *)getRootScrollView{
    
    if (!_rootScroller) {
        
        _rootScroller = [[UIScrollView alloc] initWithFrame:[self frameForPagingScrollView]];
        _rootScroller.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _rootScroller.pagingEnabled = YES;
        _rootScroller.delegate = self;
        _rootScroller.showsHorizontalScrollIndicator = NO;
        _rootScroller.showsVerticalScrollIndicator = NO;
        _rootScroller.backgroundColor = [UIColor blackColor];
        _rootScroller.contentSize = [self contentSizeForPagingScrollView];
    }
    
    return _rootScroller;
}

- (UUToolBarView *)getToolBarView{
    
    if (!_toolBarView) {
        
        CGRect frame = CGRectMake(0, CGRectGetHeight(self.view.frame) -50, ScreenWidth, 50);
        _toolBarView = [[UUToolBarView alloc] initWithBlackColor];
        _toolBarView.frame = frame;
        _toolBarView.origin = self.origin;
    }
    
    return _toolBarView;
}

- (UIButton *)getButtonSelected{

    if (!_btnSelected) {
        
        _btnSelected = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSelected.frame = CGRectMake(0, 0, 25, 25);
        [_btnSelected setImage:[UIImage imageNamed:@"UUPhoto.Bundle/ImageSelectedOff"] forState:UIControlStateNormal];
        [_btnSelected setImage:[UIImage imageNamed:@"UUPhoto.Bundle/ImageSelectedOn"] forState:UIControlStateSelected];
        [_btnSelected addTarget:self action:@selector(onClickSelected:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _btnSelected;
}

-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    self.title = titleString;
#warning  继续完善
    [self  setNavTitleString:titleString];
}

-(UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(0, 0, 25, 25);
        [_deleteButton setImage:[UIImage imageNamed:@"UUPhoto.Bundle/nav_delete_btn"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(onClickDleted:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
@end
