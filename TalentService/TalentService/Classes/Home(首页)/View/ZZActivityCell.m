//
//  ZZActivityCell.m
//  TalentService
//
//  Created by zhizhen on 15/8/25.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityCell.h"

@interface ZZActivityCell ()
@property (weak, nonatomic) IBOutlet UIImageView *showIV;
//活动标示
@property (weak, nonatomic) IBOutlet UIImageView *idenIV;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *joinCountlabel;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;


@end
@implementation ZZActivityCell

-(void)awakeFromNib{
    self.showIV.contentMode = UIViewContentModeScaleAspectFill;
    self.showIV.clipsToBounds = YES;
    self.idenIV.contentMode = UIViewContentModeScaleAspectFill;
    self.idenIV.clipsToBounds = YES;
    self.titleLabel.textColor = ZZNatiBarColor;
    self.joinCountlabel.textColor = ZZLightGrayColor;
    [self.cityButton setTitleColor:ZZLightGrayColor forState:UIControlStateNormal];
    
    
}

+(ZZActivityCell *)dequeueReusableCellTableView:(UITableView *)tableView{
    ZZActivityCell *cell = [tableView  dequeueReusableCellWithIdentifier:[ZZActivityCell  cellXibIdentifier]];
    if (cell == nil) {
        NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"ZZActivityCell" owner:nil options:nil];
        cell = [objs lastObject];
    }
    return cell;
}
+ (NSString *)cellXibIdentifier{
    return @"ActivityCell";
}

+ (CGFloat)cellHeight{
    return 64.0+ScreenWidth/2;
}


-(void)setActivity:(ZZActivity *)activity{
    _activity = activity;
    NSString* imageName = nil;
    switch (activity.status) {
        case 1:
           imageName = @"reserving_60x60";
            break;
        case 2:
            if (activity.isReserve) {
                imageName = @"reserved_60x60";
            }else{
                imageName = @"reserving_60x60";
            }
            break;
        case 3:
            imageName = @"overdue_60x60";
            break;
        default:
            
            break;
    }
    self.idenIV.image = [UIImage  imageNamed:imageName];
    self.titleLabel.text = activity.title;
        self.priceLabel.text = [NSString  stringWithFormat:@"%@",activity.price];
    self.joinCountlabel.text = [NSString  stringWithFormat:@"参加人数 %ld/%ld",activity.realityPeoples,activity.peoples];
    self.cityButton.title = activity.cityText;

   [self.showIV  setPictureImageWithURL:activity.servicesImg];
}
@end
