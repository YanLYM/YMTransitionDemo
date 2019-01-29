//
//  YMCardFromViewController.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/24.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMCardFromViewController.h"
#import "YMCardToViewController.h"
#import "YMCardPresentationController.h"

@interface YMCardFromViewController ()
@property (nonatomic, strong) UIButton * leftItem;
@property (nonatomic, strong) UIButton *presentBtn;
@end

@implementation YMCardFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItem];
    self.title = @"PopupVc";
    [self.view addSubview:self.presentBtn];
}
-(void)backClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)event_present {
    YMCardToViewController *vc = [YMCardToViewController new];
    YMCardPresentationController *presentationController = [[YMCardPresentationController alloc] initWithPresentedViewController:vc presentingViewController:self];
    vc.transitioningDelegate = presentationController;
    [self presentViewController:vc animated:YES completion:nil];
}
- (UIButton *)presentBtn {
    if (nil == _presentBtn) {
        _presentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_presentBtn setTitle:@"Present" forState:UIControlStateNormal];
        [_presentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_presentBtn addTarget:self action:@selector(event_present) forControlEvents:UIControlEventTouchUpInside];
        _presentBtn.frame = CGRectMake(100, 150, 80, 50);
    }
    return _presentBtn;
}
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
