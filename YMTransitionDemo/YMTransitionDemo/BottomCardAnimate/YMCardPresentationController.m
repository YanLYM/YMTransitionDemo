//
//  YMCardPresentationController.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/24.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMCardPresentationController.h"

@interface YMCardPresentationController () <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) UIView *dismissView;
@property (nonatomic, strong) UIView *replacePresentView;
@end
@implementation YMCardPresentationController
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(nullable UIViewController *)presentingViewController{
    
    self =[super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        
        // 自定义modalPresentationStyle
        presentedViewController.modalPresentationStyle= UIModalPresentationCustom;
        
    }
    return self;
}

/**
 present将要执行
 */
- (void)presentationTransitionWillBegin {
    self.replacePresentView = [[UIView alloc] initWithFrame:[self frameOfPresentedViewInContainerView]];
    self.replacePresentView.layer.cornerRadius = 16;
    self.replacePresentView.layer.shadowOpacity = 0.44f;
    self.replacePresentView.layer.shadowRadius = 13.f;
    self.replacePresentView.layer.shadowOffset = CGSizeMake(0, -6.f);
    UIView *presentedView = [super presentedView];
    presentedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.replacePresentView addSubview:presentedView];
    
    UIView *dismissView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    [self.containerView addSubview:dismissView];
    self.dismissView = dismissView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_dismiss)];
    [self.dismissView addGestureRecognizer:tap];
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    self.dismissView.alpha = 0.f;
    self.dismissView.backgroundColor = [UIColor blackColor];
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        self.dismissView.alpha = 0.5f;
        
    } completion:NULL];
    
}
/**
 present执行结束
 */
- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        self.dismissView = nil;
    }
}
/**
 dismiss将要执行
 */
- (void)dismissalTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        self.dismissView.alpha = 0.f;
        
    } completion:NULL];
}
/**
 dismiss执行结束
 */
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed == YES)
    {
        self.dismissView = nil;
    }
}
- (UIView *)presentedView {
    return self.replacePresentView;
}
- (void)gesture_dismiss {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    BOOL present = (toVc.presentingViewController == fromVc) ? YES : NO;
    if (present) {
        toView.frame = CGRectMake(0, containerView.bounds.size.height, containerView.bounds.size.width, 420);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.frame = CGRectMake(0, containerView.bounds.size.height - 420, containerView.bounds.size.width, 420);
        } completion:^(BOOL finished) {
            BOOL cancel = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!cancel];
        }];
    } else {
        fromView.frame = CGRectMake(0, containerView.bounds.size.height - 420, containerView.bounds.size.width, 420);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.frame = CGRectMake(0, containerView.bounds.size.height, containerView.bounds.size.width, 420);
        } completion:^(BOOL finished) {
            BOOL cancel = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!cancel];
        }];
    }
}
#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
    
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    return self;
}

@end
