//
//  ZZAddImageCell.h
//  TalentService
//
//  Created by zhizhen on 15/8/31.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZAddImageCell;
@protocol ZZAddImageCellDelegate <NSObject>

- (void)addImageCellDelete:(ZZAddImageCell *)addImageCell;

@end

@interface ZZAddImageCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;
+ (NSString *)addImageCellIdentifier;

@property (nonatomic, weak) id<ZZAddImageCellDelegate> delegate;
@end
