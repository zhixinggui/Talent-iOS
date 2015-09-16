//
//  ZZSexSelector.m
//  TalentService
//
//  Created by charles on 15/9/16.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZSexSelector.h"
@interface ZZSexSelector ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)NSArray *sexArray;
@property(nonatomic,strong)NSString *sexString;
@property (weak, nonatomic) IBOutlet UIPickerView *sexPickView;

@end

@implementation ZZSexSelector

-(void)awakeFromNib{
    self.frame = [UIApplication  sharedApplication].keyWindow.bounds;
}

- (IBAction)sexCancelButton:(UIButton *)sender {
    if ([self.delegate  respondsToSelector:@selector(sexSelectorCancelSelected:)]) {
        [self.delegate  sexSelectorCancelSelected:self];
    }
    [self  dismissAnimation];
}
- (IBAction)sexSaveButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sexSelectordidSelected:selectedSex:)]) {
        [self.delegate  sexSelectordidSelected:self selectedSex:self.sexString];
    }
    [self  dismissAnimation];
}

#pragma mark -共有方法
- (void)showAnimation{
    [[UIApplication  sharedApplication].keyWindow.rootViewController.view  addSubview:self];
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


#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.sexArray.count;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:14]];
    }
    pickerLabel.text = self.sexArray[row];
    return pickerLabel;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.sexString = self.sexArray[row];
}

#pragma mark - Setters and Getters
-(NSArray *)sexArray{
    if (!_sexArray) {
        _sexArray = @[@"男",@"女"];
    }
    return _sexArray;
}

@end
