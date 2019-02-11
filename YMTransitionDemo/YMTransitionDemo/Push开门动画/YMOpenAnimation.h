//
//  YMOpenAnimation.h
//  YMTransitionDemo
//
//  Created by Max on 2019/1/30.
//  Copyright © 2019年 Max. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMOpenAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isPop;

@end

NS_ASSUME_NONNULL_END
