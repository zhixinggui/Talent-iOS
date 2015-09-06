//
//  ZZMyselfCell.h
//  TalentService
//
//  Created by charles on 15/9/6.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZMyselfCellModel.h"
#define myselfCellCelldentifier @"myselfCellCelldentifier"
@interface ZZMyselfCell : UITableViewCell
@property(nonatomic ,strong)ZZMyselfCellModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
