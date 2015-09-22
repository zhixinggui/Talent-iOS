//
//  ZZStarTableViewCell.h
//  TalentService
//
//  Created by zhizhen on 15/9/21.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZStarTableViewCell,ZZBaseUser;
@protocol ZZStarTableViewCellDelegate <NSObject>
- (void)starCellHeadImageTap:(ZZStarTableViewCell *)starTableViewCell;
@end
@interface ZZStarTableViewCell : UITableViewCell

+ (instancetype)starTableViewCellWithTableView: (UITableView *)tableView delegate: (id <ZZStarTableViewCellDelegate>)delegate;
+ (instancetype)starCellViewWithDelegate: (id <ZZStarTableViewCellDelegate>)delegate;
+ (CGFloat )starCellHeight;
+ (NSString *)starCellIdentifier;

@property (nonatomic ,weak)ZZBaseUser *baseUser;
@end
