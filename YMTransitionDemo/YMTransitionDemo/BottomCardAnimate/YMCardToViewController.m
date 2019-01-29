//
//  YMCardToViewController.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/24.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMCardToViewController.h"

@interface YMCardToViewController ()
@property (nonatomic, strong) UIButton *dismissBtn;
@end

@implementation YMCardToViewController

- (void)loadView {
    [super loadView];
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, 420);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.view.layer.cornerRadius = 16;
    [self.view addSubview:self.dismissBtn];
}

- (void)event_dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lazyloading
- (UIButton *)dismissBtn {
    if (nil == _dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_dismissBtn setTitle:@"Dismiss" forState:UIControlStateNormal];
        [_dismissBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(event_dismiss) forControlEvents:UIControlEventTouchUpInside];
        _dismissBtn.frame = CGRectMake(100, 100, 80, 50);
    }
    return _dismissBtn;
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
