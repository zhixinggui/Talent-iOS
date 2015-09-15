//
//  ZZSelectorView.h
//  TalentService
//
//  Created by zhizhen on 15/9/14.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZSelectorView;
@protocol ZZSelectorViewDlegate <NSObject>

- (void)selectorView:(ZZSelectorView *)selectorView selectedIndex:(NSUInteger)index type:(NSUInteger)type;

@end
@interface ZZSelectorView : UITableView

@property (nonatomic, strong)NSArray *datas;
@property (nonatomic, assign) NSUInteger type;
@end
