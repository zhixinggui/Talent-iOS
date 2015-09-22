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
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *idenLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (strong ,nonatomic) HCSStarRatingView *starRatingView;
@property (weak, nonatomic) id <ZZStarTableViewCellDelegate> delegate;
@end
@implementation ZZStarTableViewCell

-(HCSStarRatingView *)starRatingView{
    if (_starRatingView == nil) {
        _starRatingView = [[HCSStarRatingView  alloc]init];
        _starRatingView.maximumValue = 5;
        _starRatingView.minimumValue = 0;
        _starRatingView.value = 4;
        _starRatingView.allowsHalfStars = NO;
        _starRatingView.spacing = 5;
        _starRatingView.userInteractionEnabled = NO;
        _starRatingView.tintColor = [UIColor blueColor];
    }
    return _starRatingView;
}
-(void)awakeFromNib{
    self.starRatingView.frame = self.starView.frame;
    self.starView.hidden = YES;
    [self.contentView  addSubview:self.starRatingView];
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
        if (cell == nil) {
            NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"ZZStarTableViewCell" owner:nil options:nil];
            cell = [objs firstObject];
        }
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
