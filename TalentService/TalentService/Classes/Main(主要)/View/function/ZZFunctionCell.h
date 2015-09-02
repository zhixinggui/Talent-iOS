//
//  ZZFunctionCell.h
//  TalentService
//
//  Created by zhizhen on 15/9/2.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFunctionShowRule.h"
@interface ZZFunctionCell : UICollectionViewCell

@property (nonatomic, weak) id <ZZFunctionShowRuleDelegate> showRule;

+ (NSString *)functionCellIdentifier;
@end
