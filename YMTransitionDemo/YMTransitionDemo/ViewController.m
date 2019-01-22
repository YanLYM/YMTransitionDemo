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

@interface ViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"首页";
    self.view.backgroundColor = [UIColor yellowColor];
    
}
- (IBAction)event_push:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YMPushViewController *vc = [sb instantiateViewControllerWithIdentifier:@"YMPushViewController"];
    
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    vc.transitioningDelegate = self;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)event_modal:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YMSwipeFromViewController *vc = [sb instantiateViewControllerWithIdentifier:@"YMSwipeFromViewController"];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc]  animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}
/**
 弹出
 */
- (IBAction)event_popup:(id)sender {
    YMPopupFromViewController *vc = [YMPopupFromViewController new];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}
- (IBAction)event_circle:(id)sender {
    YMCircleFromViewController *vc = [YMCircleFromViewController new];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}
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
