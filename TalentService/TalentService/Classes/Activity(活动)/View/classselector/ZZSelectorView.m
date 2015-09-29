//
//  ZZSelectorView.m
//  TalentService
//
//  Created by zhizhen on 15/9/14.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZSelectorView.h"
#import "ZZFunctionShowRule.h"
@interface ZZSelectorView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation ZZSelectorView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super  initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    }
    return self;
}
- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    self.height= datas.count*44;
    
 
    [self  setNeedsLayout];
    [self  reloadData];
}
-(void)setSelectedRow:(NSInteger)selectedRow{
    _selectedRow = selectedRow;
    [self  selectRowAtIndexPath:[NSIndexPath  indexPathForRow:selectedRow inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

static NSString *identifier = @"SelectorViewcell";
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = ZZContentFont;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.minimumScaleFactor = 10.0;
    }
    id <ZZSelectorViewShowDele> object = self.datas[indexPath.row];
    cell .textLabel.text = [object content];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.selecedDelegate  respondsToSelector:@selector(selectorView:selected:type:)]){
        [self.selecedDelegate  selectorView:self selected:self.datas[indexPath.row] type:self.type];
    }
}

@end
