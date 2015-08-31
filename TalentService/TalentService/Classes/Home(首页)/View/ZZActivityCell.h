//
//  ZZActivityCell.h
//  TalentService
//
//  Created by zhizhen on 15/8/25.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZActivityCell : UITableViewCell

+(ZZActivityCell *)dequeueReusableCellTableView:(UITableView *)tableView;
/**
 *  在xib中的标识符
 *
 *  @return <#return value description#>
 */
+ (NSString *)cellXibIdentifier;

/**
 *  cell的固定宽高
 *
 *  @return <#return value description#>
 */
+ (CGFloat)cellHeight;
@end
