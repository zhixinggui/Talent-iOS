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
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation ZZActivityCell

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
    return 190.0;
}
@end
