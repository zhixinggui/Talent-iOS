//
//  ZZDetailsView.h
//  TalentService
//
//  Created by zhizhen on 15/8/26.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZDetailsView;
@protocol ZZDetailsViewDelegate <NSObject>

- (void)detailsViewImageClicked:(ZZDetailsView *)detailsView;

@end
@interface ZZDetailsView : UIView
@property (nonatomic, weak) id<ZZDetailsViewDelegate>  delegate;
@property (nonatomic)CGFloat totalHeight;
@end
