//
//  ZZTopicSelectView.m
//  TalentService
//
//  Created by zhizhen on 15/10/20.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import "ZZTopicSelectView.h"
#import "ZZSIzeFitButton.h"
@implementation ZZTopicSelectView

-(void)awakeFromNib{
    self.selecteButton.sizeFitButtonType = ZZSIzeFitButtonTypeTitleLeft;
    self.searchBar.barStyle = UIBarStyleBlackTranslucent;
}

@end
