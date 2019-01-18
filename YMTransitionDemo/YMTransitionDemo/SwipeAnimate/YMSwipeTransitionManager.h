//
//  YMSwipeTransitionManager.h
//  YMTransitionDemo
//
//  Created by Max on 2019/1/17.
//  Copyright © 2019年 Max. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMSwipeTransitionManager : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong, nullable) UIScreenEdgePanGestureRecognizer * gestureRecognizer;
@property (nonatomic, readwrite) UIRectEdge targetEdge;


@end

NS_ASSUME_NONNULL_END
