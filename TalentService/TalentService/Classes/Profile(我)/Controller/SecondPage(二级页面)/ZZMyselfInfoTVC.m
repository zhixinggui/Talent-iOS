//
//  ZZMyselfInfoTVC.m
//  TalentService
//
//  Created by charles on 15/9/6.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZMyselfInfoTVC.h"
#import "ZZMyselfCell.h"
#import "ZZMyselfCellModel.h"
@interface ZZMyselfInfoTVC ()
@property (weak, nonatomic) IBOutlet UIButton *changeInfoBT;
@property(nonatomic ,strong)NSArray *cellNameArray;
@property(nonatomic ,strong)ZZMyselfCellModel *myselfCellModel;
@end

@implementation ZZMyselfInfoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    UINib* nib = [UINib nibWithNibName:@"ZZMyselfCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:myselfCellCelldentifier];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = self.changeInfoBT;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZMyselfCell *cell = [tableView dequeueReusableCellWithIdentifier:myselfCellCelldentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellNameLabel.text = self.cellNameArray[indexPath.row];
    switch (indexPath.row) {
        case 0:
        {
            cell.contentLabel.text = @"";
            cell.headIV.backgroundColor = [UIColor blackColor];
        }
            break;
            
        case 1:
        {
            cell.contentLabel.text = self.myselfCellModel.name;
        }
            break;
            
        case 2:
        {
            cell.contentLabel.text = self.myselfCellModel.phoneNum;
        }
            break;
            
        case 3:
        {
            cell.contentLabel.text = self.myselfCellModel.address;
        }
            break;
            
        case 4:
        {
            cell.contentLabel.text  = self.myselfCellModel.sex;
        }
            break;
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

#pragma mark -Setters and Getters
-(NSArray *)cellNameArray{
    if (!_cellNameArray) {
        _cellNameArray = @[@"头像",@"昵称",@"手机号码",@"联系地址",@"性别"];
    }
    return _cellNameArray;
}

-(ZZMyselfCellModel *)myselfCellModel{
    if (!_myselfCellModel) {
        _myselfCellModel = [[ZZMyselfCellModel alloc]init];
        _myselfCellModel.headImageString = @"";
        _myselfCellModel.name = @"昵称";
        _myselfCellModel.phoneNum = @"13800000000";
        _myselfCellModel.address = @"上海市杨浦区";
        _myselfCellModel.sex = @"男";
    }
    return _myselfCellModel;
}
@end
