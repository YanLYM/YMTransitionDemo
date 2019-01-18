//
//  YMSwipeInteractiveTransition.h
//  YMTransitionDemo
//
//  Created by Max on 2019/1/17.
//  Copyright © 2019年 Max. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMSwipeInteractiveTransition : UIPercentDrivenInteractiveTransition


//NS_DESIGNATED_INITIALIZER关键字 意思是最终被指定的初始化方法，在interface只能用一次而且必须以init开头的方法。
- (instancetype)initWithGestureRecognizer:(UIScreenEdgePanGestureRecognizer*)gestureRecognizer edgeForDragging:(UIRectEdge)edge NS_DESIGNATED_INITIALIZER;

// NS_UNAVAILABLE 这个宏的意思的不能用,有这个宏你在前面调用的时候Xcode是不会提示这个方法的
// 要是你非这么写了，再里面还添加了断言，会Crash
- (instancetype)init NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
