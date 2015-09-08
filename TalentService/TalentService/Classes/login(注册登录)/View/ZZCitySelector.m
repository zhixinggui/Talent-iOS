//
//  ZZCitySelector.m
//  TalentService
//
//  Created by zhizhen on 15/9/8.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZCitySelector.h"
#import "ZZCityTool.h"

@interface ZZCitySelector ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong)NSArray *provinceArray;
@property (nonatomic, weak)id <ZZCitySelectorDelegate> delgate;

@end
@implementation ZZCitySelector
+ (instancetype)citySelectorWithProvinceArray:(NSArray *)array  delegate:(id<ZZCitySelectorDelegate>) delegate{
    ZZCitySelector *citySelector = [[[NSBundle  mainBundle]loadNibNamed:@"ZZCitySelector" owner:nil options:nil]lastObject];
    citySelector.delgate = delegate;
    citySelector.provinceArray = array;
    return citySelector;
}
-(void)awakeFromNib{
    self.frame = [UIScreen  mainScreen].bounds;
}
- (ZZCity *)selectedCity{
    if (_selectedCity == nil) {
        _selectedCity = self.selectedProvince.cities[0];
    }
    return _selectedCity;
}

-(ZZProvince *)selectedProvince{
    if (_selectedProvince == nil) {
        _selectedProvince = self.provinceArray[0];
    }
    return _selectedProvince;
}

-(ZZCounty *)selectedCounty{
    if (_selectedCounty == nil) {
        _selectedCounty = self.selectedCity.counties[0];
    }
    return _selectedCounty;
}

- (IBAction)cancellButtonAction:(UIButton *)sender {
    if ([self.delgate  respondsToSelector:@selector(citySelectorCancellSelect:)]) {
        [self.delgate  citySelectorCancellSelect:self];
    }
    [self  dismissAnimation];
}

- (IBAction)saveBuutonAction:(UIButton *)sender {
    
    if ([self.delgate respondsToSelector:@selector(citySelectorSelect:selectedProvince:selectedCity:selectedCounty:)]) {
        [self.delgate  citySelectorSelect:self selectedProvince:self.self.selectedProvince selectedCity:self.selectedCity selectedCounty:self.selectedCounty];
    }
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
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArray.count;
    }else if (component == 1){
    
        return self.selectedProvince.cities.count;
    }else{
        ZZLog(@",,,%@,,,%@",self.selectedCity,self.selectedProvince);
            return self.selectedCity.counties.count;
       
        
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        
        return self.selectedProvince.name;
    }else if (component == 1){
        
        return self.selectedCity.name;
    }else{
        
        return self.selectedCounty.name;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        //更改当前选中省份的索引
        self.selectedProvince = self.provinceArray[row];
        
        //刷新第二组数据
        [pickerView reloadComponent:1];
        
        //选中第一个
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }else if(component == 1){
        self.selectedCity = self.selectedProvince.cities[row];
        
        //刷新第三组数据
        [pickerView reloadComponent:2];
        
        //选中第一个
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else{
        self.selectedCounty = self.selectedCity.counties[row];
    }
}
@end
