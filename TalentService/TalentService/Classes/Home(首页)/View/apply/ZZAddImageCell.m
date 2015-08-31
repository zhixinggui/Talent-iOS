//
//  ZZAddImageCell.m
//  TalentService
//
//  Created by zhizhen on 15/8/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZAddImageCell.h"

@interface ZZAddImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *addIV;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
@implementation ZZAddImageCell

-(void)awakeFromNib{
    self.deleteButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
}
- (IBAction)deleteButtonAction:(UIButton *)sender {
    if ([self.delegate  respondsToSelector:@selector(addImageCellDelete:)]) {
        [self.delegate  addImageCellDelete:self];
    }
}
-(void)setImage:(UIImage *)image{
    _image = image;
    if (image) {
        self.addIV.image = image;
        self.deleteButton.hidden = NO;
    }else{
        self.addIV.image = [UIImage  imageNamed:@"add_range_64x112"];
        self.deleteButton.hidden = YES;
    }
    
    
}
+ (NSString *)addImageCellIdentifier{
    return @"AddImageCell";
}
@end
