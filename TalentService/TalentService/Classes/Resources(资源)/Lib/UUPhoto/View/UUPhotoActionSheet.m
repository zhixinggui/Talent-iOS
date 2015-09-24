//
//  UUPhotoActionSheet.m
//  UUPhotoActionSheet
//
//  Created by zhangyu on 15/7/10.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUPhotoActionSheet.h"
#import "UUThumbnailView.h"
#import "UUAssetManager.h"
#import "UUPhotoGroupViewController.h"
#import "UUPhotoConst.h"
#import "ZZUploadImageModel.h"
#import <AVFoundation/AVFoundation.h>
@interface UUPhotoActionSheet() < UIImagePickerControllerDelegate,
                                  UINavigationControllerDelegate >

@property (nonatomic, strong, getter = getSheetView) UIView *sheetView;

@property (nonatomic, strong, getter = getButtonAlbum) UIButton *btnAlbum;

@property (nonatomic, strong, getter = getButtonCamera) UIButton *btnCamera;

@property (nonatomic, strong, getter = getButtonCancel) UIButton *btnCancel;

@property (nonatomic, strong, getter = getThumbnailView) UUThumbnailView *thumbnailView;

@property (nonatomic, weak) UIViewController *weakSuper;


@end

@implementation UUPhotoActionSheet

- (instancetype)initWithWeakSuper:(id)weakSuper{
    if (self = [super init]) {
        
        [self configUI];
        _weakSuper = weakSuper;
       
    }
    return self;
}

-(void)layoutSubviews{
    [super  layoutSubviews];
      self.btnCancel.frame = CGRectMake(0, CGRectGetHeight(self.sheetView.frame) -50, ScreenWidth, 50);
      self.btnAlbum.frame = CGRectMake(0, CGRectGetMinY(self.btnCancel.frame) -60, ScreenWidth, 50);
     self.btnCamera.frame = CGRectMake(0, CGRectGetMinY(self.btnAlbum.frame) -51, ScreenWidth, 50);
}
#pragma mark - life cycle

- (void)configUI{
    
    self.alpha = 0;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.frame =  CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self addSubview:self.sheetView];
    [self.sheetView addSubview:self.btnCancel];
    [self.sheetView addSubview:self.btnAlbum];
    [self.sheetView addSubview:self.btnCamera];
    [self configNotification];
}

- (void)configNotification{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationSendPhotos:)
                                                 name:kNotificationSendPhotos
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationUpdateSelected:)
                                                 name:kNotificationUpdateSelected
                                               object:nil];

}

- (void)dealloc{

    _weakSuper = nil;
    
    [[UUAssetManager sharedInstance] clearData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    UIImage *editedImage ;
    if (self.head) {
        editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    }else{
        editedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    ZZUploadImageModel *uploadModel = [[ZZUploadImageModel alloc]init];
    CGFloat  wid = ScreenWidth *[UIScreen  mainScreen].scale ;
    CGFloat  heitht = wid * editedImage.size.height/editedImage.size.width;
    editedImage = [editedImage imageWithImage:editedImage scaledToSize:CGSizeMake(wid, heitht)];
    uploadModel.image = editedImage;
    
    [picker dismissViewControllerAnimated:YES completion:^{
    
        [self sendImageArray:@[uploadModel]];
    }];
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Custom Deledate

- (void)sendImageArray:(NSArray *)obj{

    if (_delegate && [_delegate respondsToSelector:@selector(actionSheetDidFinished:)]) {
        
        [_delegate actionSheetDidFinished:obj];
    }
}

#pragma mark - Event Response

- (void)onClickCamera:(id)sender{

    [self openSystemPhotoCameraWithSourceType:UIImagePickerControllerSourceTypeCamera];
    [self  requestCameraStatus];

}
- (void)requestCameraStatus{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AVAuthorizationStatus  authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo                                                                                                                                                                                                                                                                                                                                                        ];
        if (authStatus == AVAuthorizationStatusAuthorized) {//有访问权限
            
            
        }else  if(authStatus == AVAuthorizationStatusNotDetermined){//没有授权过
            
        }else{//没有访问权限
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self  tipDeviceAccessPermission:@"相机"];
            });
            
        }
    });
}
/**
 *  点击打开相册
 *
 *  @param sender <#sender description#>
 */
- (void)onClickAlbum:(id)sender{

    ALAuthorizationStatus  authStatus = [ALAssetsLibrary authorizationStatus];
    if (authStatus == ALAuthorizationStatusAuthorized || authStatus ==ALAuthorizationStatusNotDetermined ) {// 有访问权限或没有咨询过
        if (self.head) {
            [self  openSystemPhotoCameraWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }else{
            [self  openCustomPhoto];
        }
        
    }else{//没有访问权限
        [self  tipDeviceAccessPermission:@"相册"];
    }
  
}

- (void)onClickCancel:(id)sender{
    
    [[UUAssetManager sharedInstance].selectdPhotos removeAllObjects];
    [self cancelAnimation:YES];
}

- (void)notificationSendPhotos:(NSNotification *)note{
    
    NSDictionary  *userInfo = note.userInfo;
    BOOL ori =  [userInfo[ImageOrigin] boolValue];
    [_weakSuper dismissViewControllerAnimated:YES completion:^{
        
    }];
    NSUInteger type = ori ? ASSET_PHOTO_SCREEN_SIZE : ASSET_PHOTO_ASPECT_THUMBNAIL;
    [self sendImageArray:[[UUAssetManager sharedInstance] sendSelectedPhotos:type]];
    [self cancelAnimation:NO];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [[UUAssetManager sharedInstance].selectdPhotos removeAllObjects];
    [self cancelAnimation:YES];
}

#pragma mark - Public Methods

- (void)showAnimation{
    [_btnCamera setTitle:@"拍照" forState:UIControlStateNormal];
    CGFloat height = 0;
    if (self.thumb) {
        self.thumbnailView.frame = CGRectMake(0, 0, ScreenWidth, 190);
        height = CGRectGetMaxY(self.thumbnailView.frame);
        [_thumbnailView reloadView];
    }
    self.sheetView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 160 + height);
    

    //self.alertWindow.windowLevel = UIWindowLevelAlert;
   UIWindow *window = [[UIApplication sharedApplication] keyWindow];
   // NSLog(@",,,%@",window.subviews);
    [window  addSubview:self];

      CGRect frame = _sheetView.frame;
    frame.origin.y = ScreenHeight - _sheetView.frame.size.height;
    [UIView animateWithDuration:.25f animations:^{
        _sheetView.frame = frame;
        self.alpha = 1;
    }];
    
}


#pragma mark - Private Methods

- (void)presentViewController:(UIViewController *)viewController{
    @try {
      
        [[[[UIApplication sharedApplication].windows firstObject] rootViewController] presentViewController:viewController animated:YES completion:nil];
         [self cancelAnimation:NO];
    }
    @catch (NSException *exception) {
        [[[[UIApplication sharedApplication].windows lastObject] rootViewController] presentViewController:viewController animated:YES completion:nil];
        [self cancelAnimation:NO];
    }
}

/**
 *  打开自定义相册，一次可上传多张
 */
- (void)openCustomPhoto{
    
    UINavigationController *naviController;
    naviController = [[UINavigationController alloc] initWithRootViewController:UUPhotoGroupViewController.new];
    [self  presentViewController:naviController];
   
    [UUAssetManager sharedInstance].maxSelected = self.maxSelected;
}

//打开系统自带相册 相机一次选择一张图片
-(void)openSystemPhotoCameraWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    
    if ([UIImagePickerController  isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = sourceType;
        imagePicker.allowsEditing = self.head;
        if([[[UIDevice
              currentDevice] systemVersion] floatValue]>=8.0 && sourceType == UIImagePickerControllerSourceTypeCamera) {
            
            imagePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            
        }
        [self  presentViewController:imagePicker];
    }else{
        UIAlertView  *alert = [[UIAlertView  alloc]initWithTitle:@"提示" message:@"这个设备没有此功能" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
    }
   
}

#warning self write 访问权限提醒
-(void)tipDeviceAccessPermission:(NSString*)deviceType{
    NSString *title  = [NSString  stringWithFormat:@"无法访问%@",deviceType];
    NSString *message = [NSString  stringWithFormat:@"请在设备的\"设置-隐私-%@\"中允许\"萌宝派\"访问%@。",deviceType,deviceType];
    
    UIAlertView  *alert = [[UIAlertView  alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alert show];
}


- (void)notificationUpdateSelected:(NSNotification *)note{
    
    NSInteger count = [[UUAssetManager sharedInstance] getSelectedPhotoCount];
    if (count == 0) {
        
        _btnCamera.selected = YES;
        [_btnCamera setTitle:@"拍照" forState:UIControlStateNormal];
        return;
    }
    
    _btnCamera.selected = NO;
    NSString *name = [NSString stringWithFormat:@"发送 (%ld)张",count];
    [_btnCamera setTitle:name forState:UIControlStateNormal];
}

- (void)cancelAnimation:(BOOL )animation{

    CGRect frame = _sheetView.frame;
    frame.origin.y = ScreenHeight;
    NSTimeInterval time = 0;
    if (animation) {
        time = .25f;
    }
    [UIView  animateWithDuration:time animations:^{
        _sheetView.frame = frame;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self  removeFromSuperview];
        }
    }];
 
}

#pragma mark - Getters And Setters

-(void)setMaxSelected:(NSUInteger)maxSelected{
    _maxSelected = maxSelected;
    
}

- (UIView *)getSheetView{

    if (!_sheetView) {
        _sheetView = [[UIView alloc] init];
        _sheetView.backgroundColor = COLOR_WITH_RGB(230,231,234,1);
    }
    
    return _sheetView;
}

- (UIButton *)getButtonCancel{

    if (!_btnCancel) {
        
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancel setTitleColor:COLOR_WITH_RGB(94,201,252,1) forState:UIControlStateNormal];
        _btnCancel.backgroundColor = [UIColor whiteColor];
        
        [_btnCancel addTarget:self action:@selector(onClickCancel:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _btnCancel;
}

- (UIButton *)getButtonCamera{
    
    if (!_btnCamera) {
        
        _btnCamera = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCamera setTitle:@"拍照" forState:UIControlStateNormal];
        [_btnCamera setTitleColor:COLOR_WITH_RGB(94,201,252,1) forState:UIControlStateNormal];
        _btnCamera.backgroundColor = [UIColor whiteColor];
        [_btnCamera addTarget:self action:@selector(onClickCamera:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnCamera;
}


- (UIButton *)getButtonAlbum{
    
    if (!_btnAlbum) {
        
        _btnAlbum = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAlbum setTitle:@"相册" forState:UIControlStateNormal];
        [_btnAlbum setTitleColor:COLOR_WITH_RGB(94,201,252,1) forState:UIControlStateNormal];
        _btnAlbum.backgroundColor = [UIColor whiteColor];
        [_btnAlbum addTarget:self action:@selector(onClickAlbum:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnAlbum;
}

- (UUThumbnailView *)getThumbnailView{
  
    if (!_thumbnailView) {
        
        CGRect frame = CGRectMake(0, 0, ScreenWidth, 190);
        _thumbnailView = [[UUThumbnailView alloc] initWithFrame:frame];
    }
    
    return _thumbnailView;
}

-(void)setThumb:(BOOL)thumb{
    _thumb = thumb;
    if (thumb) {
           [self.sheetView addSubview:self.thumbnailView];
    }
}


@end
