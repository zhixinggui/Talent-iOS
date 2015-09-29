//
//  ZZOrderTopView.m
//  TalentService
//
//  Created by zhizhen on 15/9/28.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZOrderTopView.h"
#import "ZZActivity.h"
#import "ZZActivityDetailController.h"
@interface ZZOrderTopView ()
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *citylabel;
@property (weak, nonatomic) IBOutlet UILabel *pariceLabel;


@end
@implementation ZZOrderTopView

+ (instancetype)orderTopView{
    return [[[ NSBundle mainBundle]loadNibNamed:@"ZZOrderTopView" owner:nil options:nil]lastObject];
}
-(void)awakeFromNib{
    self.bounds = CGRectMake(0, 0, ScreenWidth, ScreenWidth/2);
}

-(void)setActivity:(ZZActivity *)activity{
    _activity = activity;
    
    [self.activityImageView  setPictureImageWithURL:activity.servicesImg];
    self.titleLabel.text = activity.title;
    self.citylabel.text = activity.cityText;
    self.pariceLabel.text = activity.price;
}

-(void)setJump:(BOOL)jump{
    _jump = jump;
    if (jump) {
        [self.activityImageView  addTarget:self action:@selector(jumpToActivityDetail)];
    }
}

- (void)jumpToActivityDetail{
    ZZActivityDetailController *activityDetailVC = [[ZZActivityDetailController  alloc]init];
    activityDetailVC.activityId = self.activity.activityId;
    [self.vcDelegate.navigationController pushViewController:activityDetailVC animated:YES];
}

@end
