//
//  ZZOrderCell.h
//  TalentService
//
//  Created by charles on 15/9/1.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#define orderCelldentifier @"orderCelldentifier"
@interface ZZOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *cancelBT;
@property (weak, nonatomic) IBOutlet UIButton *goodBT;
@property (weak, nonatomic) IBOutlet UIButton *badBT;


@end
