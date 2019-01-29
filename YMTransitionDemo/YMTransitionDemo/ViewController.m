//
//  ViewController.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/11.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "ViewController.h"
#import "YMPushViewController.h"
#import "YMFadeInAnimate.h"
#import "YMSwipeFromViewController.h"
#import "YMPopupFromViewController.h"
#import "YMCircleFromViewController.h"
#import "YMFadeFromViewController.h"
#import "YMCardFromViewController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.title = @"首页";
    self.view.backgroundColor = [UIColor yellowColor];
    self.dataSource = @[@"渐显",@"侧滑",@"弹性Pop",@"扩散圆",@"底部卡片"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"点击了cell - %ld",indexPath.row);
    if (indexPath.row == 0) {
        YMFadeFromViewController *vc = [YMFadeFromViewController new];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    } else if (indexPath.row == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        YMSwipeFromViewController *vc = [sb instantiateViewControllerWithIdentifier:@"YMSwipeFromViewController"];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc]  animated:YES completion:nil];
    } else if (indexPath.row == 2) {
        //弹性pop
        YMPopupFromViewController *vc = [YMPopupFromViewController new];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    } else if (indexPath.row == 3) {
        //圆圈扩散
        YMCircleFromViewController *vc = [YMCircleFromViewController new];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    } else if (indexPath.row == 4) {
        YMCardFromViewController *vc = [YMCardFromViewController new];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    }
//    switch (indexPath.row) {
//        case 0:
//            {   //渐显
//                YMFadeFromViewController *vc = [YMFadeFromViewController new];
//                [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
//            }
//            break;
//        case 1:
//        {       //侧滑
//            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            YMSwipeFromViewController *vc = [sb instantiateViewControllerWithIdentifier:@"YMSwipeFromViewController"];
//            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc]  animated:YES completion:nil];
//        }
//            break;
//        case 2:
//        {   //弹性pop
//            YMPopupFromViewController *vc = [YMPopupFromViewController new];
//            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
//        }
//            break;
//        case 3:
//        {   //圆圈扩散
//            YMCircleFromViewController *vc = [YMCircleFromViewController new];
//            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
//        }
//            break;
//        case 4:
//        {
//            YMCardFromViewController *vc = [YMCardFromViewController new];
//            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
//        }
//            break;
//        default:
//            break;
//    }
}
//- (IBAction)event_push:(id)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    YMPushViewController *vc = [sb instantiateViewControllerWithIdentifier:@"YMPushViewController"];
//
////    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    vc.modalPresentationStyle = UIModalPresentationCustom;
//    vc.transitioningDelegate = self;
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
////    [self.navigationController pushViewController:vc animated:YES];
//}
//- (IBAction)event_modal:(id)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    YMSwipeFromViewController *vc = [sb instantiateViewControllerWithIdentifier:@"YMSwipeFromViewController"];
//    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc]  animated:YES completion:nil];
////    [self.navigationController pushViewController:vc animated:YES];
//}
///**
// 弹出
// */
//- (IBAction)event_popup:(id)sender {
//    YMPopupFromViewController *vc = [YMPopupFromViewController new];
//    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
//}
//- (IBAction)event_circle:(id)sender {
//    YMCircleFromViewController *vc = [YMCircleFromViewController new];
//    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
//}
#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [YMFadeInAnimate new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [YMFadeInAnimate new];
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;
//
//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0);

@end
