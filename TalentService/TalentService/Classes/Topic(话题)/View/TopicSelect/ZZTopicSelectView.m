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
    self.searchBar.barStyle = UIBarStyleDefault;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.searchBar setBackgroundColor:[UIColor  whiteColor]];
    //        [_searchBarView setBackgroundColor:[UIColor colorWithRed:0.28 green:0.6 blue:0.79 alpha:1]];
    
    self.searchBar.layer.masksToBounds  = YES;
    self.searchBar.placeholder = @"话题";
}

-(void)layoutSubviews{
    [super  layoutSubviews];
    self.searchBar.layer.cornerRadius = self.searchBar.frame.size.height/2;
}
@end
