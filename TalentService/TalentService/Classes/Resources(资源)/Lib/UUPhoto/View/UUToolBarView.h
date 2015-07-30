//
//  UUToolBarView.h
//  UUPhotoActionSheet
//
//  Created by zhangyu on 15/7/10.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UUToolBarView : UIView

@property (nonatomic,getter=isOrigin)BOOL origin;

- (instancetype)initWithWhiteColor;

- (instancetype)initWithBlackColor;

- (void)addPreviewTarget:(id)target action:(SEL)action;

@end
