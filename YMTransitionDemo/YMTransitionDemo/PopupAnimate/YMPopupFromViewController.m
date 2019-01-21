//
//  YMPopupFromViewController.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/21.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMPopupFromViewController.h"
#import "YMPopupToViewController.h"
#import "YMPopupAnimation.h"

@interface YMPopupFromViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIButton *completeBtn;
@property (nonatomic, strong) UIButton *presentBtn;

@end

@implementation YMPopupFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    self.title = @"PopupVc";
    [self.view addSubview:self.presentBtn];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sccnn.jpg"]];
    imageView.frame = CGRectMake((self.view.frame.size.width-250)/2, CGRectGetMaxY(self.presentBtn.frame)+20, 250, 250);
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    
}
- (void)event_present {
    YMPopupToViewController *vc = [YMPopupToViewController new];
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}
#pragma UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [YMPopupAnimation new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [YMPopupAnimation new];
}

#pragma mark - Lazyloading
- (UIButton *)presentBtn {
    if (nil == _presentBtn) {
        _presentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_presentBtn setTitle:@"Popup" forState:UIControlStateNormal];
        [_presentBtn addTarget:self action:@selector(event_present) forControlEvents:UIControlEventTouchUpInside];
        _presentBtn.frame = CGRectMake(100, 150, 80, 50);
    }
    return _presentBtn;
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
