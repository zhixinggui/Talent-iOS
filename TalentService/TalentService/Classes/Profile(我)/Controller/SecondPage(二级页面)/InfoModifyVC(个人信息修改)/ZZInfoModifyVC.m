//
//  ZZInfoModifyVC.m
//  TalentService
//
//  Created by charles on 15/9/10.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZInfoModifyVC.h"
#import "UUPhotoActionSheet.h"
#import "ZZModifyVC.h"
#import "ZZUploadImageModel.h"

#import "ZZUploadImageTool.h"

#import "ZZChangeInfoParam.h"
#import "ZZChangePhoneNumVC.h"
#import "ZZCitySelector.h"
#import "ZZCityTool.h"
#import "ZZSexSelector.h"
#import "ZZLoginUserTool.h"
#import "ZZMyInfoHttpTool.h"
#import "ZZFirstLoginVC.h"
#import "ZZWriteDetailAddressVC.h"
#import "ZZUMMessageTool.h"
#import "ZZTextView.h"
#import "ZZHudView.h"
#import "ZZStarDetailVC.h"
@interface ZZInfoModifyVC ()<UUPhotoActionSheetDelegate,ZZCitySelectorDelegate,UITextViewDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *changScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
/** 选择图片*/
@property (nonatomic, strong) UUPhotoActionSheet *sheet;

@property (nonatomic, strong) ZZCity *selectedCity;
@property (nonatomic, strong) ZZProvince *selectedProvince;
@property (nonatomic, strong) ZZCounty *selectedCounty;

@property (nonatomic ,strong)UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIImageView *starDetailView;
@property (weak, nonatomic) IBOutlet UILabel *starDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightIV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *changeInfoLayoutConstraint;
@end



@implementation ZZInfoModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"我的";
    /**
     *  个人信息
     */
    [self  notice];
   

    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice) name:ZZUserNickChangeNoti object:nil];
    
    
}
//接听通知
-(void)notice{
    
    ZZLoginUser *loginUser = [ZZLoginUserTool  sharedZZLoginUserTool].loginUser;
    self.nameLabel.text = loginUser.userNike;
    self.phoneLabel.text = loginUser.userPhone;
    self.adressLabel.text = loginUser.userAddress;
    if (loginUser.userPresentation.length) {
        self.contentLabel.text = loginUser.userPresentation;
    }else {
        self.contentLabel.text = @"未填写";
    }
    
    [self.headIV setHeadImageWithURL:loginUser.userSmallImg];
    ZZLog(@"是男是女:%ld",loginUser.userSex);
    if (loginUser.userSex == 1) {
        self.sexLabel.text = @"男";
    }else{
       self.sexLabel.text = @"女";
    }
    
    if (loginUser.isEredar) {
        self.starDetailView.hidden = NO;
        self.starDetailLabel.hidden = NO;
        self.contentLabel.hidden = NO;
        self.rightIV.hidden = NO;
        self.changeInfoLayoutConstraint.constant = 62;
    }else {
        self.starDetailView.hidden = YES;
        self.starDetailLabel.hidden = YES;
        self.contentLabel.hidden = YES;
        self.rightIV.hidden = YES;
        self.changeInfoLayoutConstraint.constant = 8;
    }

}

- (IBAction)gotoModifyHeadIv:(UIButton *)sender {
    ZZLog(@"改头像");
    [self.sheet showAnimation];
    
}

- (IBAction)gotoModifyName:(UIButton *)sender {
    
    ZZLog(@"改名字");
    
    ZZModifyVC *modifyVc = [[ZZModifyVC alloc]initWithNib];
    [self.navigationController pushViewController:modifyVc animated:YES];
}

- (IBAction)gotoModifyPhoneNum:(UIButton *)sender {
    ZZLog(@"改手机号码");
    ZZChangePhoneNumVC *phoneNemVc = [[ZZChangePhoneNumVC alloc]initWithNib];
    [self.navigationController pushViewController:phoneNemVc animated:YES];
}

- (IBAction)gotoModifyAddress:(UIButton *)sender {
    ZZLog(@"改地址");
    ZZWriteDetailAddressVC *writeAddress = [[ZZWriteDetailAddressVC alloc] initWithNib];
    [self.navigationController pushViewController:writeAddress animated:YES];
}

#pragma mark -ZZCitySelectorDelegate

-(void)citySelectorSelect:(ZZCitySelector *)citySelector selectedProvince:(ZZProvince *)selectedProvince selectedCity:(ZZCity *)selectedCity selectedCounty:(ZZCounty *)selectedCounty{
    
    self.selectedProvince = selectedProvince;
    self.selectedCounty = selectedCounty;
    self.selectedCity = selectedCity;
    self.cityLabel.text = [NSString  stringWithFormat:@"%@%@%@",selectedProvince.name,selectedCity.name,selectedCounty.name];
    
    //上传地址
    ZZChangeInfoParam *infoParam = [[ZZChangeInfoParam alloc]init];
    infoParam.city = @(self.selectedCity.cityId);
    infoParam.province = @(self.selectedProvince.provinceId);
    infoParam.district = @(self.selectedCounty.countyId);
    [MBProgressHUD showMessage:@"正在保存中..."];
    
    [ZZMyInfoHttpTool changeInfoWithChangeInfoParam:infoParam success:^(ZZLoginUser *infoUser, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showSuccess:@"保存成功"];

    } failure:^(NSString *error, ZZNetDataType datatype) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showError:error];
    }];
    
}


- (IBAction)gotoModifySex:(UIButton *)sender {
    ZZLog(@"改性别");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"性别"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"男", @"女",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    ZZLog(@"%ld",buttonIndex);
    //上传性别
    ZZChangeInfoParam *infoParam = [[ZZChangeInfoParam alloc]init];
    infoParam.userSex = @(buttonIndex+1);
    [MBProgressHUD showMessage:@"正在保存中..."];
    [ZZMyInfoHttpTool changeInfoWithChangeInfoParam:infoParam success:^(ZZLoginUser *infoUser, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showSuccess:@"保存成功"];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showError:error];
    }];
}


- (IBAction)didClickOnCity:(UIButton *)sender {
    ZZLog(@"改城市");
    ZZCitySelector *citySelector = [ZZCitySelector  citySelectorWithProvinceArray:[ZZCityTool  sharedZZCityTool].provinceGroups delegate:self];
    [citySelector  setSelectedProvince:self.selectedProvince city:self.selectedCity county:self.selectedCounty];
    [citySelector showAnimation];
}

#pragma mark -UUPhotoActionSheetDelegate
- (void)actionSheetDidFinished:(NSArray *)obj{
    ZZUploadImageModel *imageModel = obj[0];
    ZZLog(@"11111%@",obj);
    self.headIV.image = imageModel.image;
    [MBProgressHUD showMessage:@"正在保存中..."];
    //上传修改信息
    ZZChangeInfoParam *changeInfoParam = [[ZZChangeInfoParam alloc]init];
    [ZZMyInfoHttpTool commitHeadImageWithImageArray:obj ChangeInfoParam:changeInfoParam success:^(ZZLoginUser *infoUser, ZZNetDataType dataType) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showSuccess:@"保存成功"];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showError:error];
    }];
}

- (IBAction)didClickOnDetail:(UIButton *)sender {
    ZZLog(@"达人描述");
    ZZStarDetailVC *starDetailVc = [[ZZStarDetailVC alloc]initWithNib];
    [self.navigationController pushViewController:starDetailVc animated:YES];
}


- (IBAction)didClickOnCancel:(UIButton *)sender {
    
    [MBProgressHUD showMessage:@"正在注销中..."];
    [ZZMyInfoHttpTool signOutAppSuccess:^(ZZLoginUser *infoUser, ZZNetDataType dataType) {
        [ ZZUMMessageTool umMessageRemoveAlias];
    
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showSuccess:@"注销成功"];
        [[ZZLoginUserTool sharedZZLoginUserTool] save:nil];
        [self swithWindowRootControllerToLogin];
    } failure:^(NSString *error, ZZNetDataType datatype) {
        [MBProgressHUD  hideHUD];
        [MBProgressHUD  showError:error];
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -Setters and Getters
-(UUPhotoActionSheet *)sheet{
    if (_sheet == nil) {
        _sheet = [[UUPhotoActionSheet alloc] initWithWeakSuper:self];
        _sheet.delegate = self;
        _sheet.head = YES;
    }
    return _sheet;
}

-(void)dealloc{
    [[NSNotificationCenter  defaultCenter]removeObserver:self ];
}
@end
