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
@property (nonatomic, strong) ZZCity *selectedCity;
@property (nonatomic, strong) ZZProvince *selectedProvince;
@property (nonatomic, strong) ZZCounty *selectedCounty;
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

- (void)setSelectedProvince:(ZZProvince *)province city:(ZZCity *)city county:(ZZCounty *)county{
    if (province == nil || city== nil || county == nil) {
        return;
    }
    self.selectedProvince = province;
    [self.pickerView selectRow:[self.provinceArray  indexOfObject:province] inComponent:0 animated:YES];
    
    self.selectedCity = city;
    [self.pickerView selectRow:[province.cities indexOfObject:city] inComponent:1 animated:YES];
    
    self.selectedCounty = county;
    [self.pickerView selectRow:[city.counties  indexOfObject:county] inComponent:2 animated:YES];
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
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArray.count;
    }else if (component == 1){
        return self.selectedProvince.cities.count;
    }else{
    return self.selectedCity.counties.count;
    }

}

//-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSString *str ;
//    if (component == 0) {
//        ZZProvince *province = self.provinceArray[row];
//      str = province.name;
//    }else if (component == 1){
//        ZZCity *city = self.selectedProvince.cities[row];
//        str =  city.name;
//    }else{
//        ZZCounty *county = self.selectedCity.counties[row];
//       str =  county.name;
//    }
//    
////    NSMutableAttributedString *attributedString = [[NSMutableAttributedString   alloc]
////    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle  alloc] init];
////    paragraphStyle.alignment = NSTextAlignmentLeft;
////    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
////    
////    NSRange range = NSMakeRange(0,attributedString.length);
////    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
////    //字体大小
////    if (font) {
////        [attributedString  addAttributes:@{NSFontAttributeName:font} range:range];
////    }
////    if (color) {
////        [attributedString  addAttributes:@{NSForegroundColorAttributeName :color} range:range];
////    }
//    NSMutableAttributedString  *astr = [[NSMutableAttributedString  alloc]initWithString:str];
//
// [astr  addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, str.length)];
//    ZZLog(@",,%@..%@",str,astr);
//    return astr;
//}
//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//
//    if (component == 0) {
//        ZZProvince *province = self.provinceArray[row];
//        return  province.name;
//    }else if (component == 1){
//        ZZCity *city = self.selectedProvince.cities[row];
//       return  city.name;
//    }else{
//        ZZCounty *county = self.selectedCity.counties[row];
//       return  county.name;
//    }
//}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel  = nil;

        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 30)];
        pickerLabel.minimumScaleFactor = 8;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:14]];
 
    if (component == 0) {
        ZZProvince *province = self.provinceArray[row];
        pickerLabel.text = province.name;
    }else if (component == 1){
        ZZCity *city = self.selectedProvince.cities[row];
        pickerLabel.text = city.name;
    }else{
        ZZCounty *county = self.selectedCity.counties[row];
        pickerLabel.text = county.name;
    }
    return pickerLabel;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        //更改当前选中省份的索引
        self.selectedProvince = self.provinceArray[row];
        ZZLog(@"sehng:%@",self.selectedProvince.name);
        //刷新第二组数据
        [pickerView reloadComponent:1];
        
        [self  pickerView:self.pickerView didSelectRow:0 inComponent:1];

    }else if(component == 1){
        self.selectedCity = self.selectedProvince.cities[row];
        ZZLog(@"city:%@",self.selectedCity.name);
        //刷新第三组数据
        [pickerView reloadComponent:2];
        
        //选中第一个
         [self  pickerView:self.pickerView didSelectRow:0 inComponent:2];
   
    }else{
        self.selectedCounty = self.selectedCity.counties[row];
            ZZLog(@"county:%@",self.selectedCounty.name);
    }
}


@end
