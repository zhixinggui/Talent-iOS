//
//  UUPhotoBrowserViewController.h
//  UUPhotoActionSheet
//
//  Created by zhangyu on 15/7/10.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUAssetManager.h"
@class UUToolBarView;
@class UUPhotoBrowserViewController;

@protocol UUPhotoBrowserDelegate < NSObject >

/**
 *  显示的图片
 *
 *  @param index   第几张
 *  @param browser
 *
 *  @return 对应的图片
 */
- (UIImage *)displayImageWithIndex:(NSInteger)index fromPhotoBrowser:(UUPhotoBrowserViewController *)browser;

/**
 *  图片总数
 *
 *  @param browser
 *
 *  @return 要显示的图片总数
 */
- (NSInteger)numberOfPhotosFromPhotoBrowser:(UUPhotoBrowserViewController *)browser;

/**
 *  从那一张开始显示
 *
 *  @param browser <#browser description#>
 *
 *  @return 当前选中的要第一个显示的图片位数，从0开始
 */
- (NSInteger)jumpIndexFromPhotoBrowser:(UUPhotoBrowserViewController *)browser;



@optional

/**
 *  告诉那张图片被删除了
 *  canDelete为Yes  必须执行这个方法，
 *  @param index   图片的位数 从0开始
 *  @param browser <#browser description#>
 */
- (void)deleteIndex:(NSUInteger)index fromPhotoBrowser:(UUPhotoBrowserViewController *)browser;

/**
 *  坐标为index的图片是否被选中
 *  canDelete  为NO 时，必须有这个方法,
 *  @param index   图片的坐标 从0开始
 *  @param browser <#browser description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isSelectedPhotosWithIndex:(NSInteger)index fromPhotoBrowser:(UUPhotoBrowserViewController *)browser;

/**
 *  是否检测最大选中数
 *  canDelete  为NO 时，必须有这个方法,
 *  @param browser <#browser description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isCheckMaxSelectedFromPhotoBrowser:(UUPhotoBrowserViewController *)browser;

/**
 *  有图片被选中或者取消选中，调用这个方法
 *  canDelete  为NO 时，必须有这个方法,
 *  @param index    <#index description#>
 *  @param selected <#selected description#>
 */
- (void)displayImageWithIndex:(NSUInteger)index selectedChanged:(BOOL)selected;
@end

@interface UUPhotoBrowserViewController : UIViewController

/**
 *  是否是原图，保持与外面图片选择的地方一致
 */
@property (nonatomic) BOOL origin;

/**
 *  是否显示删除按钮，与origin  只能有一个yes
 */
@property (nonatomic) BOOL canDelete;

/**
 *  代理
 */
 @property (nonatomic, weak) id<UUPhotoBrowserDelegate> delegate;

@end



