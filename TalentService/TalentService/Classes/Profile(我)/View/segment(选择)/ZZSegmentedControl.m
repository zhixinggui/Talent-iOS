//
//  ZZSegmentedControl.m
//  TalentService
//
//  Created by charles on 15/8/28.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZSegmentedControl.h"
@interface ZZSegmentedControl()
@property(nonatomic,strong)UILabel *lineLabel;
@end
@implementation ZZSegmentedControl
-(instancetype)initWithItems:(NSArray *)items{
    self = [super initWithItems:items];
    if (self) {
        [self setSegmentControll];
    }
    return self;
}

-(void)setSegmentControll{
    self.tintColor = [UIColor clearColor];
    [self setBackgroundColor:[UIColor whiteColor]];
    self.exclusiveTouch = YES; //不可多点同时点下
    NSDictionary *seleted = [NSDictionary dictionaryWithObjectsAndKeys:ZZNatiBarColor,NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName ,nil];
    [self setTitleTextAttributes:seleted forState:UIControlStateSelected];
    
    NSDictionary *disseleted = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName ,nil];
    [self setTitleTextAttributes:disseleted forState:UIControlStateNormal];
    
    [self addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    self.selectedSegmentIndex = 0;
    
    /**
     *  横线
     */
    self.lineLabel = [[UILabel alloc]init];
    self.lineLabel.height = 2;
    self.lineLabel.backgroundColor = ZZNatiBarColor;
    [self addSubview:self.lineLabel];
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    self.lineLabel.width = self.width/self.numberOfSegments;
    self.lineLabel.y = self.height-2;
    
}



-(void)change:(UISegmentedControl*)seg{
    NSUInteger  index = seg.numberOfSegments;
    [UIView  animateWithDuration:0.25 animations:^{
        self.lineLabel.x = (self.width/index)*seg.selectedSegmentIndex;
    }];
    
    if ([self.delegate   respondsToSelector:@selector(segmentControl:andIndex:)]) {
        [self.delegate  segmentControl:self andIndex:seg.selectedSegmentIndex];
    }
    
}
@end
