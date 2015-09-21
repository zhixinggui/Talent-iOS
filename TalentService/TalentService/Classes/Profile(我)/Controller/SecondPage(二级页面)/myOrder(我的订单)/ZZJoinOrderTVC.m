//
//  ZZJoinOrderTVC.m
//  TalentService
//
//  Created by charles on 15/9/2.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZJoinOrderTVC.h"
#import "ZZJoinOrderCell.h"
#import "ZZSegmentedControl.h"
#import "ZZTestingVC.h"
@interface ZZJoinOrderTVC ()<ZZSegmentedControlDelegate>
@property(nonatomic,strong)ZZSegmentedControl *orderSegmentControl;
@end

@implementation ZZJoinOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的服务";
    UINib* nib = [UINib nibWithNibName:@"ZZJoinOrderCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:jionOrderCelldentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 76;
    
    [self setNavRightItemWithName:@"验证" target:self action:@selector(testingAction:)];
}

/**
 *  navigation右button
 */
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem  alloc]initWithTitle:name style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}


/**
 *  跳转验证
 */
- (void)testingAction:(UIButton *)sender {
    ZZLog(@"验证");
    ZZTestingVC *testingVc = [[ZZTestingVC alloc]initWithNib];
    [self.navigationController pushViewController:testingVc animated:YES];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  event delegate
-(void)segmentControl:(ZZSegmentedControl *)segment andIndex:(NSUInteger)index{
    ZZLog(@"切换%ld",index);
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZJoinOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:jionOrderCelldentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.self.orderSegmentControl;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
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


#pragma mark - Table view delegate
/*
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    ZZNextJionOrderTVC *detailViewController = [[ZZNextJionOrderTVC alloc] initWithNib];
    
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
#pragma mark setter andGetter
-(ZZSegmentedControl *)orderSegmentControl{
    if (!_orderSegmentControl) {
        _orderSegmentControl = [[ZZSegmentedControl alloc]initWithItems:@[@"已接单",@"已验证"]];
        _orderSegmentControl.delegate = self;
        _orderSegmentControl.frame = CGRectMake(0, 0, ScreenWidth, 40);
    }
    return _orderSegmentControl;
}
@end
