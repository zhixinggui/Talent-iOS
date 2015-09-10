//
//  ZZSegmentedControl.h
//  TalentService
//
//  Created by charles on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZSegmentedControl;
@protocol ZZSegmentedControlDelegate <NSObject>

- (void)segmentControl:(ZZSegmentedControl *)segment andIndex:(NSUInteger)index;

@end
@interface ZZSegmentedControl : UISegmentedControl
@property (nonatomic, weak)id<ZZSegmentedControlDelegate> delegate;
@end
