//
//  ZZPictureAndDetailVIew.h
//  TalentService
//
//  Created by charles on 15/11/4.
//  Copyright © 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZPictureAndDetailVIew : UIView
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *pictureLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureIVHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureLabelHeight;


@end
