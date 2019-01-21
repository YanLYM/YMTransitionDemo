//
//  YMPopupAnimation.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/21.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMPopupAnimation.h"

@implementation YMPopupAnimation
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return .35;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    BOOL present = (toVc.presentingViewController == fromVc);
    UIView *tempView = nil;
    if (present) {
        tempView = [fromVc.view snapshotViewAfterScreenUpdates:NO];
        tempView.frame = fromVc.view.frame;
        fromVc.view.hidden = YES;
        [containerView addSubview:tempView];
        [containerView addSubview:toVc.view];
        toVc.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, 400);
    } else {
        //参照present动画的逻辑，present成功后，containerView的最后一个子视图就是截图视图，我们将其取出准备动画
        NSArray *subviewsArray = containerView.subviews;
        tempView = subviewsArray[MIN(subviewsArray.count, MAX(0, subviewsArray.count - 2))];
    }
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (present) {
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
            tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
            toVc.view.transform = CGAffineTransformMakeTranslation(0, -400);
        } completion:^(BOOL finished) {
            BOOL cancel = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!cancel];
            if (cancel) {
                fromVc.view.hidden = NO;
                [tempView removeFromSuperview];
            }
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            fromVc.view.transform = CGAffineTransformIdentity;
            tempView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            BOOL cancel = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!cancel];
            if (!cancel) {
                toVc.view.hidden = NO;
                [tempView removeFromSuperview];
            }
        }];
    }
    
}
@end
