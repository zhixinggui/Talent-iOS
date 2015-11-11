//
//  MLKMenuPopover.h
//  MLKMenuPopover
//
//  Created by NagaMalleswar on 20/11/14.
//  Copyright (c) 2014 NagaMalleswar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLKMenuPopover;

@protocol MLKMenuPopoverDelegate

- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex;

@end

typedef enum{
    MLKMenuPopoverArrowDirectionLeft = 1,
    MLKMenuPopoverArrowDirectionMiddle = 2,
    MLKMenuPopoverArrowDirectionRight = 3
}MLKMenuPopoverArrowDirection;
@interface MLKMenuPopover : UIView <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign) id<MLKMenuPopoverDelegate> menuPopoverDelegate;

@property (nonatomic, strong)NSArray *itemImageNames;
//默认向右/
@property (nonatomic) MLKMenuPopoverArrowDirection arrowDirection;
//是否在视图中/
@property (nonatomic, readonly,getter=isShow)BOOL show;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems;
- (void)showInView:(UIView *)view;
- (void)dismissMenuPopover;
- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
