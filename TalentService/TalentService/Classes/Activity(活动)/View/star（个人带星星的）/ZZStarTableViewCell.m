//
//  ZZStarTableViewCell.m
//  TalentService
//
//  Created by zhizhen on 15/9/21.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZStarTableViewCell.h"
#import "HCSStarRatingView.h"
#import "ZZBaseUser.h"
@interface ZZStarTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicklabel;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *idenLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansLabel;

@property (weak, nonatomic) id <ZZStarTableViewCellDelegate> delegate;
@end
@implementation ZZStarTableViewCell

-(void)awakeFromNib{
 
    self.starView.maximumValue = 5;
    self.starView.minimumValue = 0;
    self.starView.value = 4;
    self.starView.allowsHalfStars = NO;
    self.starView.spacing = 5;
    self.starView.userInteractionEnabled = NO;
    
    self.starView.tintColor = ZZYellowColor;

}
-(void)setBaseUser:(ZZBaseUser *)baseUser{
    _baseUser = baseUser;
  
    self.nicklabel.text = baseUser.userNike;
    if (baseUser.userRole.count) {
        ZZUserRole *userRole = [baseUser.userRole firstObject];
        self.idenLabel.text = userRole.eredarName;
    }else{
        self.idenLabel.text = nil;
    }
    self.fansLabel.text = [NSString stringWithFormat:@"Fans(%ld)",baseUser.fans];
    [self.headImageView setHeadImageWithURL:baseUser.userSmallImg];
}

- (IBAction)headTap:(UITapGestureRecognizer *)sender {
    
    if ([self.delegate  respondsToSelector:@selector(starCellHeadImageTap:)]) {
        [self.delegate  starCellHeadImageTap:self];
    }
}

+(instancetype)starTableViewCellWithTableView:(UITableView *)tableView delegate:(id<ZZStarTableViewCellDelegate>)delegate{
    ZZStarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZZStarTableViewCell  starCellIdentifier]];

        if (cell == nil) {
            NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"ZZStarTableViewCell" owner:nil options:nil];
            cell = [objs firstObject];
            cell.delegate = delegate;
        }
    return cell;
}

+(instancetype)starCellViewWithDelegate:(id<ZZStarTableViewCellDelegate>)delegate{
    ZZStarTableViewCell *starView = [[[NSBundle mainBundle] loadNibNamed:@"ZZStarTableViewCell" owner:nil options:nil]firstObject];
    starView.delegate = delegate;
    return starView;
}

+(CGFloat)starCellHeight{
    return 80.0;
}

+(NSString *)starCellIdentifier{
    return @"ZZStarTableViewCell";
}
@end
