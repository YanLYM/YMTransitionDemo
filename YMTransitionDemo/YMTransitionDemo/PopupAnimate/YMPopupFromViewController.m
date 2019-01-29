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
@property (nonatomic, strong) UIButton * leftItem;
@property (nonatomic, strong) UIButton *presentBtn;

@end

@implementation YMPopupFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItem];
    self.title = @"PopupVc";
    [self.view addSubview:self.presentBtn];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgImage.jpg"]];
    imageView.frame = CGRectMake((self.view.frame.size.width-250)/2, CGRectGetMaxY(self.presentBtn.frame)+20, 250, 250);
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    
}

-(void)backClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)event_present {
    YMPopupToViewController *vc = [YMPopupToViewController new];
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
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
-(UIButton *)leftItem{
    
    if (!_leftItem) {
        
        _leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftItem.frame = CGRectMake(0, 0,50, 20);
        [_leftItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftItem setTitle:@"Back" forState:UIControlStateNormal];
        [_leftItem addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftItem;
}
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
