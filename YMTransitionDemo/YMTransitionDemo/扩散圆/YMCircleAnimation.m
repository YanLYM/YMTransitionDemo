//
//  YMCircleAnimation.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/21.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMCircleAnimation.h"
#import "YMCircleFromViewController.h"

@interface YMCircleAnimation () <CAAnimationDelegate>
@property (nonatomic, assign) BOOL isPresentOrDismiss;

@end

@implementation YMCircleAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    BOOL present = (toVc.presentingViewController == fromVc);
    if (present) {  //present
        [self presentViewControllerWithTransition:transitionContext];
    } else {    //dismiss
        [self dismissViewControllerWithTransition:transitionContext];
    }
}
- (void)presentViewControllerWithTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UINavigationController *navVc = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    YMCircleFromViewController * fromVc = navVc.viewControllers.lastObject;
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVc.view];
    
    UIBezierPath *startCircle = [UIBezierPath bezierPathWithOvalInRect:fromVc.presentBtn.frame];
    // sqrtf 求平方根函数  pow求次方函数，这里的意思是求X的2次方，要是pow(m,9)就是求m的9次方
    CGFloat radius = sqrtf(pow(containerView.frame.size.width, 2) + pow(containerView.frame.size.height, 2));
    UIBezierPath *endCircle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCircle.CGPath;
    toVc.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation * maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startCircle.CGPath);
    maskLayerAnimation.toValue   = (__bridge id)((endCircle.CGPath));
    maskLayerAnimation.duration  = [self transitionDuration:transitionContext];
    
    //速度控制函数
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    // 添加动画
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}
- (void)dismissViewControllerWithTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController * fromViewController     = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController * toViewController = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    YMCircleFromViewController * tempViewController = toViewController.viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    //当modalPresentationStyle = UIModalPresentationCustom 时不用添加fromViewController.view，因为视图不会被移除, 为UIModalPresentationFullScreen 时需要添加，否则背景是黑的
      [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    //画两个圆路径，这里的结束和开始时候的画的圆的道理和present的时候正好是相反的
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath * startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    // 结束的就是tempViewController.presentNextController.frame的大小
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:tempViewController.presentBtn.frame];
    
    //创建CAShapeLayer
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromViewController.view.layer.mask = maskLayer;
    
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate  = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue   = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration  = [self transitionDuration:transitionContext];
    
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (_isPresentOrDismiss) {
        // 标记转场结束
        id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
        [transitionContext completeTransition:YES];
    }else{
        //
        id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            
            [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
        }
    }
}

@end
