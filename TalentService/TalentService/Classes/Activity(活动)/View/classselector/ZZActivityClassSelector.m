//
//  ZZActivityClassSelector.m
//  TalentService
//
//  Created by zhizhen on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZActivityClassSelector.h"

@interface ZZActivityClassSelector ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
@property (weak, nonatomic) UIViewController<ZZActivityClassSelectorDelegate> *delegate;
@end
@implementation ZZActivityClassSelector
+(instancetype)activityClassSelectorWithDlegate:(UIViewController<ZZActivityClassSelectorDelegate> *) delgate{
    ZZActivityClassSelector *activityCS = [[[NSBundle mainBundle]loadNibNamed:@"ZZActivityClassSelector" owner:nil options:nil]lastObject];
    activityCS.delegate = delgate;
    return activityCS;
}

-(void)setTitle:(NSString *)title{
    self.selectLabel.text = title;
}
#pragma mark -UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.datas.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    id<ZZActivityClassSelectorShowDele> show = self.datas[row];
    return [show showInfo];
    
}


- (IBAction)cancellButtonAction:(UIButton *)sender {
    [self  dismissAnimation];
}

- (IBAction)sureButtonAction:(UIButton *)sender {
    
    if ([self.delegate  respondsToSelector:@selector(activityClassSelector:selectNsobject:title:)]) {
        NSInteger selectedRow = [self.pickerView  selectedRowInComponent:0];
        if (selectedRow < 0) {
            selectedRow = 0;
        }
        id<ZZActivityClassSelectorShowDele> object = self.datas[selectedRow];
        [self.delegate  activityClassSelector:self selectNsobject:object title:self.title];
    }
    [self  dismissAnimation];
}

- (void)showAnimation{
   [[UIApplication  sharedApplication].keyWindow.rootViewController.view  addSubview:self];
//    [self.delegate.navigationController.view addSubview:self];
    self.y = ScreenHeight ;
    [UIView  animateWithDuration:animationTime animations:^{
        self.y = 0;
    }];
}

- (void)dismissAnimation{
    [UIView animateWithDuration:animationTime animations:^{
        self.y = ScreenHeight;
    } completion:^(BOOL finished) {
        [self  removeFromSuperview];
    }];
}
@end
