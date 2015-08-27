//
//  ZZDetailImageView.h
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZDetailImageView;
@protocol ZZDetailImageViewDelegate <NSObject>

- (void)detailImageViewADCliceked:(ZZDetailImageView *)detalImageViewDelegate;

- (void)detailImageViewBooking:(ZZDetailImageView *)detalImageViewDelegate;

@end
@interface ZZDetailImageView : UIView

@property (nonatomic, weak)id<ZZDetailImageViewDelegate> delegate;
@property (nonatomic)CGFloat totalHeight;
@end
