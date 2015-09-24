//
//  ZZSelectorView.h
//  TalentService
//
//  Created by zhizhen on 15/9/14.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFunctionShowRule.h"
@class ZZSelectorView;
@protocol ZZSelectorViewDlegate <NSObject>

- (void)selectorView:(ZZSelectorView *)selectorView selected:(id<ZZSelectorViewShowDele>)selectedObject type:(NSUInteger)type;

@end
@interface ZZSelectorView : UITableView

@property (nonatomic, weak)id <ZZSelectorViewDlegate> selecedDelegate;
/**要显示的数据  数据中的元素需遵守ZZSelectorViewShowDele协议*/
@property (nonatomic, strong)NSArray *datas;
/**显示的数据类型，方便回传判断*/
@property (nonatomic, assign) NSUInteger type;
/**默认选中的*/
@property (nonatomic)NSInteger  selectedRow;
@end
