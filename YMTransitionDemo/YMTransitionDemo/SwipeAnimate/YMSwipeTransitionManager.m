//
//  YMSwipeTransitionManager.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/17.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMSwipeTransitionManager.h"
#import "YMSwipeAnimation.h"
#import "YMSwipeInteractiveTransition.h"

@implementation YMSwipeTransitionManager
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [YMSwipeAnimation new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [YMSwipeAnimation new];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    //有手势 返回处理交互协议对象
    if (self.gestureRecognizer) {
        return [[YMSwipeInteractiveTransition alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
    }
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    if (self.gestureRecognizer) {
        return [[YMSwipeInteractiveTransition alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
    }
    return nil;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0) {
    return nil;
}

@end
