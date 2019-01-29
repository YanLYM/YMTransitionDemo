//
//  YMSwipeInteractiveTransition.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/17.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMSwipeInteractiveTransition.h"

@interface YMSwipeInteractiveTransition ()

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong, readonly) UIScreenEdgePanGestureRecognizer * gestureRecognizer;
@property (nonatomic, readonly) UIRectEdge edge;

@end

@implementation YMSwipeInteractiveTransition

//NS_DESIGNATED_INITIALIZER关键字 意思是最终被指定的初始化方法，在interface只能用一次而且必须以init开头的方法。
- (instancetype)initWithGestureRecognizer:(UIScreenEdgePanGestureRecognizer*)gestureRecognizer edgeForDragging:(UIRectEdge)edge {
    NSAssert(edge == UIRectEdgeTop || edge == UIRectEdgeBottom ||
             edge == UIRectEdgeLeft || edge == UIRectEdgeRight,
             @"edgeForDragging must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.");
    self = [super init];
    if (self) {
        // 初始化自己的手势和 UIRectEdge edge
        // 给手势添加 gestureRecognizeDidUpdate 方法
        _gestureRecognizer = gestureRecognizer;
        _edge = edge;
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

// NS_UNAVAILABLE 这个宏的意思的不能用,有这个宏你在前面调用的时候Xcode是不会提示这个方法的
// 要是你非这么写了，再里面还添加了断言，会Crash
- (instancetype)init NS_UNAVAILABLE {
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Use -initWithGestureRecognizer:edgeForDragging:" userInfo:nil];
}

/**
 前面代理通过 interactionControllerForPresentation 方法获取交互控制器的时候，手势返回的就是SwipTransitionInteractionController，这个时候就会调用这个方法
 
 interactive 交互
 */
-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    [super startInteractiveTransition:transitionContext];
    //保存我们的交互上下文，方便做进度更新等操作
    self.transitionContext = transitionContext;
}

// 手势触发该方法
-(void)gestureRecognizeDidUpdate:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer{
    
    switch (gestureRecognizer.state){
            
            
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
            
            // 调用updateInteractiveTransition来更新动画进度
            // 里面嵌套定义 percentForGesture 方法计算动画进度
            [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            break;
            
        case UIGestureRecognizerStateEnded:
            
            //判断手势位置，要大于一般,就完成这个转场，要小于一半就取消
            if ([self percentForGesture:gestureRecognizer] >= 0.5f)
                
                // 完成交互转场
                [self finishInteractiveTransition];
            else
                // 取消交互转场
                [self cancelInteractiveTransition];
            break;
        default:
            
            [self cancelInteractiveTransition];
            break;
    }
}

// 计算动画进度
-(CGFloat)percentForGesture:(UIScreenEdgePanGestureRecognizer *)gesture{
    UIView * transitionContainerView = self.transitionContext.containerView;
    // 手势滑动 在transitionContainerView中 的位置
    // 这个位置判断的方法可以具体根据你的需求确定
    CGPoint locationInSourceView = [gesture locationInView:transitionContainerView];
    CGFloat width  = CGRectGetWidth(transitionContainerView.bounds);
    CGFloat height = CGRectGetHeight(transitionContainerView.bounds);
    if (self.edge == UIRectEdgeRight)
        return (width - locationInSourceView.x) / width;
    else if (self.edge == UIRectEdgeLeft)
        return locationInSourceView.x / width;
    else if (self.edge == UIRectEdgeBottom)
        return (height - locationInSourceView.y) / height;
    else if (self.edge == UIRectEdgeTop)
        return locationInSourceView.y / height;
    else
        return 0.f;
}
- (void)dealloc{
    
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
}
@end
