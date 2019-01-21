//
//  YMPopupToViewController.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/21.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMPopupToViewController.h"

@interface YMPopupToViewController ()
@property (nonatomic, strong) UIButton *presentBtn;
@end

@implementation YMPopupToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.presentBtn];
}
- (void)event_present {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lazyloading
- (UIButton *)presentBtn {
    if (nil == _presentBtn) {
        _presentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_presentBtn setTitle:@"Dismiss" forState:UIControlStateNormal];
        [_presentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
