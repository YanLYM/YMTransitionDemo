//
//  YMFadeInAnimate.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/16.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMFadeInAnimate.h"

@implementation YMFadeInAnimate

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *contentView = [transitionContext containerView];
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    fromView.frame = [transitionContext initialFrameForViewController:fromVc];
    toView.frame = [transitionContext finalFrameForViewController:toVc];
    [contentView addSubview:toView];
    NSTimeInterval time = [self transitionDuration:transitionContext];
    fromView.alpha = 1;
    toView.alpha = 0;
    [UIView animateWithDuration:time animations:^{
        fromView.alpha = 0;
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        BOOL cancelTransition = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!cancelTransition];
    }];
}


@end
