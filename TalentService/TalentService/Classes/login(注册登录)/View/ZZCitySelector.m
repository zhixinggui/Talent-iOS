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

@property (weak, nonatomic) UIPickerView *pickerView;
@property (nonatomic, strong)NSArray *provinceArray;
@property (nonatomic, weak)id <ZZCitySelectorDelegate> delgate;
@property (nonatomic, strong) ZZCity *selectedCity;
@property (nonatomic, strong) ZZProvince *selectedProvince;
@property (nonatomic, strong) ZZCounty *selectedCounty;

@property (nonatomic, strong) UIView *toolBar;
@end

@implementation ZZCitySelector


+ (instancetype)citySelectorWithProvinceArray:(NSArray *)array  delegate:(id<ZZCitySelectorDelegate>) delegate{
    ZZCitySelector *citySelector = [[ZZCitySelector  alloc]init];
    citySelector.delgate = delegate;
    citySelector.provinceArray = array;
    return citySelector;
}

-(void)awakeFromNib{
    self.frame = [UIScreen  mainScreen].bounds;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:[UIScreen  mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor  clearColor];
        UIView *backView = [[UIView  alloc]initWithFrame:self.bounds];
        backView.backgroundColor = [UIColor  blackColor];
        backView.alpha = 0.2;
        [self  addSubview:backView];
        [self  customInit];
    }
    return self;
}


- (void)customInit{
    
    CGFloat sw = self.width;;
    CGFloat sh = self.height;
    
    
    CGFloat w = sw;
    CGFloat h = 200;
    CGFloat x = 0;
    CGFloat y = sh - h;
   //
    UIPickerView *pickerView = [[UIPickerView  alloc]initWithFrame:CGRectMake(x, y, w, h)];
    pickerView.backgroundColor = [UIColor  whiteColor];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self  addSubview:pickerView];
    self.pickerView = pickerView;
    //
    CGFloat tw = sw;
    CGFloat th = 50;
    CGFloat tx = 0;
    CGFloat ty = CGRectGetMinY(pickerView.frame)-th;
    UIView *toolBar = [[UIView  alloc]initWithFrame:CGRectMake(tx, ty, tw, th)];
    [self  addSubview:toolBar];
    toolBar.backgroundColor = [UIColor  grayColor];
    self.toolBar = toolBar;
    //取消按钮
    CGFloat cw = 60;
    CGFloat ch = CGRectGetHeight(toolBar.frame);
    CGFloat cx = 0;
    CGFloat cy = (CGRectGetHeight(toolBar.frame) - ch)/2;
    
    UIButton *cancellButton = [[UIButton  alloc]initWithFrame:CGRectMake(cx, cy, cw, ch)];
    cancellButton.titleLabel.font = ZZContentFont;
    [cancellButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancellButton  addTarget:self action:@selector(cancellButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar  addSubview:cancellButton];
    //取消按钮
    CGFloat suw = cw;
    CGFloat suh = ch;
    CGFloat sux = CGRectGetWidth(toolBar.frame)-suw;
    CGFloat suy = (CGRectGetHeight(toolBar.frame) - ch)/2;
    UIButton *sureButton = [[UIButton  alloc]initWithFrame:CGRectMake(sux, suy, suw, suh)];
    sureButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    sureButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    sureButton.titleLabel.font = ZZContentFont;
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton  addTarget:self action:@selector(saveBuutonAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar  addSubview:sureButton];
    
    //取消按钮
    CGFloat lw = 100;
    CGFloat lh = ch;
    UILabel *titleLabel = [[UILabel  alloc]initWithFrame:CGRectMake(0, 0, lw, lh)];
    titleLabel.text = @"城市选择";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = ZZContentFont;
    titleLabel.centerX = toolBar.centerX;
    [toolBar  addSubview:titleLabel];
}
#pragma mark
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



- (void)cancellButtonAction:(UIButton *)sender {
    if ([self.delgate  respondsToSelector:@selector(citySelectorCancellSelect:)]) {
        [self.delgate  citySelectorCancellSelect:self];
    }
    [self  dismissAnimation];
}

- (void)saveBuutonAction:(UIButton *)sender {
    
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

