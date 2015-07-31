//
//  UUPhotoActionSheet.h
//  UUPhotoActionSheet
//
//  Created by zhangyu on 15/7/10.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//  要作为 对象持有下.默认缩略图，原图是缩略图的三倍左右

#import <UIKit/UIKit.h>



@class UUPhotoActionSheet;
@protocol UUPhotoActionSheetDelegate < NSObject >

- (void)actionSheetDidFinished:(NSArray *)obj;

@end

@interface UUPhotoActionSheet : UIView

/**
 *  初始化方法，只提供这一个
 *
 *  @param weakSuper 一个controller 执行回调方法
 */
- (instancetype)initWithWeakSuper:(id)weakSuper;

/**
 *  显示
 */
- (void)showAnimation;

/**
 *  是否预先加载图片选择框
 */
@property (nonatomic) BOOL thumb;

/**
 *  是否是头像，头像的话，只能一次只能一张照片
 */
@property (nonatomic, getter=isHead) BOOL head;

/**
 *  委托
 */
@property (nonatomic, weak) id<UUPhotoActionSheetDelegate> delegate;

/**
 *  一次最多加载的图片数,不能为空
 */
@property (nonatomic) NSUInteger  maxSelected;
@end


