//
//  YMFadeFromViewController.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/24.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMFadeFromViewController.h"
#import "YMFadeToViewController.h"
#import "YMFadeInAnimate.h"

@interface YMFadeFromViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIButton *presentBtn;
@end

@implementation YMFadeFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(event_back)];
    [self.view addSubview:self.presentBtn];
    
}
- (void)event_back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)event_present {
    YMFadeToViewController *vc = [YMFadeToViewController new];
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}
- (UIButton *)presentBtn {
    if (nil == _presentBtn) {
        _presentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_presentBtn setTitle:@"渐显转场" forState:UIControlStateNormal];
        _presentBtn.frame = CGRectMake(100, 200, 100, 80);
        [_presentBtn addTarget:self action:@selector(event_present) forControlEvents:UIControlEventTouchUpInside];
    }
    return _presentBtn;
}
#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [YMFadeInAnimate new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [YMFadeInAnimate new];
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
