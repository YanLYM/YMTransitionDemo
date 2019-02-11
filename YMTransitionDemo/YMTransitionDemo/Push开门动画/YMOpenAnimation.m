//
//  YMOpenAnimation.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/30.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMOpenAnimation.h"

@implementation YMOpenAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (!self.isPop) {
        [self pushWithTransition:transitionContext];
    } else {
        [self popWithTransition:transitionContext];
    }
}
- (void)pushWithTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *leftFromView = [fromView snapshotViewAfterScreenUpdates:NO];
    leftFromView.frame = fromView.frame;
    UIView *rightFromView = [fromView snapshotViewAfterScreenUpdates:NO];
    rightFromView.frame = CGRectMake(-fromView.frame.size.width/2, 0, fromView.frame.size.width, fromView.frame.size.height);
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fromView.frame.size.width/2, fromView.frame.size.height)];
    leftView.clipsToBounds = YES;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(fromView.frame.size.width/2, 0, fromView.frame.size.width/2, fromView.frame.size.height)];
    rightView.clipsToBounds = YES;
    [leftView addSubview:leftFromView];
    [rightView addSubview:rightFromView];
    [containerView addSubview:toView];
    [containerView addSubview:leftView];
    [containerView addSubview:rightView];
    NSTimeInterval interval = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:interval animations:^{
        leftView.frame = CGRectMake(-fromView.frame.size.width/2, 0, fromView.frame.size.width/2, fromView.frame.size.height);
        rightView.frame = CGRectMake(fromView.frame.size.width, 0, fromView.frame.size.width/2, fromView.frame.size.height);
    } completion:^(BOOL finished) {
        BOOL cancel = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!cancel];
        if (!cancel) {
            [leftView removeFromSuperview];
            [rightView removeFromSuperview];
        }
    }];
    
}
- (void)popWithTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //取出转场前后视图控制器上的视图view
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    //左侧动画视图
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(-toView.frame.size.width/2, 0, toView.frame.size.width/2, toView.frame.size.height)];
    leftView.clipsToBounds = YES;
    [leftView addSubview:toView];
    
    //右侧动画视图
    // 使用系统自带的snapshotViewAfterScreenUpdates:方法，参数为YES，代表视图的属性改变渲染完毕后截屏，参数为NO代表立刻将当前状态的视图截图
    UIView *rightToView = [toView snapshotViewAfterScreenUpdates:YES];
    rightToView.frame = CGRectMake(-toView.frame.size.width/2, 0, toView.frame.size.width, toView.frame.size.height);
    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(toView.frame.size.width, 0, toView.frame.size.width/2, toView.frame.size.height)];
    rightView.clipsToBounds = YES;
    [rightView addSubview:rightToView];
    
    //加入动画视图
    [containerView addSubview:fromView];
    [containerView addSubview:leftView];
    [containerView addSubview:rightView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{
                         leftView.frame = CGRectMake(0, 0, toView.frame.size.width/2, toView.frame.size.height);
                         rightView.frame = CGRectMake(toView.frame.size.width/2, 0, toView.frame.size.width/2, toView.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         //由于加入了手势交互转场，所以需要根据手势动作是否完成/取消来做操作
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         if([transitionContext transitionWasCancelled]){
                             //手势取消
                         }else{
                             //手势完成
                             [containerView addSubview:toView];
                         }
                         
                         [leftView removeFromSuperview];
                         [rightView removeFromSuperview];
                         toView.hidden = NO;
                         
                     }];
    
//    UIView *containerView = [transitionContext containerView];
//    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//
//    // 使用系统自带的snapshotViewAfterScreenUpdates:方法，参数为YES，代表视图的属性改变渲染完毕后截屏，参数为NO代表立刻将当前状态的视图截图
//    UIView *leftToView = [toView snapshotViewAfterScreenUpdates:YES];
//    leftToView.frame = fromView.frame;
//    UIView *rightToView = [toView snapshotViewAfterScreenUpdates:YES];
//    rightToView.frame = CGRectMake(-fromView.frame.size.width/2, 0, fromView.frame.size.width, fromView.frame.size.height);
//
//    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(-toView.frame.size.width/2, 0, toView.frame.size.width/2, toView.frame.size.height)];
//    leftView.clipsToBounds = YES;
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(toView.frame.size.width, 0, toView.frame.size.width/2, toView.frame.size.height)];
//    rightView.clipsToBounds = YES;
//    [leftView addSubview:leftToView];
//    [rightView addSubview:rightToView];
//    [containerView addSubview:toView];
//    toView.hidden = YES;
//    [containerView addSubview:leftView];
//    [containerView addSubview:rightView];
//    NSTimeInterval interval = [self transitionDuration:transitionContext];
//    [UIView animateWithDuration:interval animations:^{
//        leftView.frame = CGRectMake(0, 0, toView.frame.size.width/2, toView.frame.size.height);
//        rightView.frame = CGRectMake(toView.frame.size.width/2, 0, toView.frame.size.width/2, toView.frame.size.height);
//    } completion:^(BOOL finished) {
//        BOOL cancel = [transitionContext transitionWasCancelled];
//        [transitionContext completeTransition:!cancel];
//        if (!cancel) {
//            [leftView removeFromSuperview];
//            [rightView removeFromSuperview];
//            toView.hidden = NO;
//        }
//    }];
}
@end
