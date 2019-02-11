//
//  YMOpenFromViewController.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/30.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMOpenViewController.h"
#import "YMOpenAnimation.h"

@interface YMOpenViewController ()
@property (nonatomic, strong) YMOpenAnimation *animation;
@end

@implementation YMOpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"开门动画";
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        self.animation.isPop = NO;
    } else if (operation == UINavigationControllerOperationPop) {
        self.animation.isPop = YES;
    }
    return self.animation;
}

- (YMOpenAnimation *)animation {
    if (nil == _animation) {
        _animation = [[YMOpenAnimation alloc] init];
    }
    return _animation;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
