//
//  ZZSearchUserCell.m
//  TalentService
//
//  Created by zhizhen on 15/11/11.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZSearchUserCell.h"
#import "HCSStarRatingView.h"
#import "ZZHeadImageView.h"
@interface ZZSearchUserCell ()
@property (weak, nonatomic) IBOutlet ZZHeadImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *organLabel;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starView;

@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@end
@implementation ZZSearchUserCell

- (void)awakeFromNib {
    self.organLabel.backgroundColor = ZZNatiBarColor;
}

+ (NSString *)searchUserCellIdentifier{
    return @"ZZSearchUserCell";
}

+ (CGFloat)searchUserCellheight{
    return 80.0;
}

@end
