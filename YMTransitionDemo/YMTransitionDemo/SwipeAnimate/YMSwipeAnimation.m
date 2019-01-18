//
//  YMSwipeAnimation.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/17.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMSwipeAnimation.h"

@implementation YMSwipeAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    BOOL presented = NO; //为present 或者dismiss
    if (toViewController.presentingViewController == fromViewController) {
        presented = YES;
    }
//    CGVector offset;
    if (presented) {    //从右往左
//        offset = CGVectorMake(-1, 0);
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width, 0);
        [containerView addSubview:toView];
    } else {            //从左往右
//        offset = CGVectorMake(1, 0);
        fromView.frame = fromFrame;
        toView.frame = toFrame;
        [containerView insertSubview:toView belowSubview:fromView];
    }
    NSTimeInterval interval =  [self transitionDuration:transitionContext];
    [UIView animateWithDuration:interval animations:^{
        if (presented) {
            toView.frame = toFrame;
        } else {
            fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width, 0);
        }
    } completion:^(BOOL finished) {
        BOOL canceled = [transitionContext transitionWasCancelled];
        if (canceled) {
            [toView removeFromSuperview];
        }
        [transitionContext completeTransition:!canceled];
    }];
    
}

@end
