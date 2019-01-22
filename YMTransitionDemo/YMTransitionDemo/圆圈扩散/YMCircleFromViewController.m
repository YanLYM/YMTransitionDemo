//
//  YMCircleFromViewController.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/21.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMCircleFromViewController.h"
#import "YMCircleToViewController.h"
#import "YMCircleAnimation.h"

@interface YMCircleFromViewController () <UIViewControllerTransitioningDelegate>
@property(nonatomic,strong) UIButton * leftItem;
@end

@implementation YMCircleFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItem];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"sccnn.jpg"];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    [self.view addSubview:self.presentBtn];

    // Do any additional setup after loading the view.
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



-(UIButton *)presentBtn{
    
    if (!_presentBtn) {
        
        _presentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _presentBtn.backgroundColor = [UIColor grayColor];
        _presentBtn.titleLabel.numberOfLines = 0;
        _presentBtn.titleLabel.textAlignment = 1;
        _presentBtn.layer.cornerRadius = 30;
        _presentBtn.layer.masksToBounds = YES;
        _presentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _presentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        _presentBtn.frame = CGRectMake(self.view.frame.size.width-60, self.view.frame.size.height-150, 60, 60);
        
        [_presentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_presentBtn setTitle:@"点击\n拖动" forState:UIControlStateNormal];
        [_presentBtn addTarget:self action:@selector(presentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_presentBtnPan:)];
        [_presentBtn addGestureRecognizer:pan];
        
    }
    return _presentBtn;
}


-(void)_presentBtnPan:(UIPanGestureRecognizer *)recognizer{
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint newCenter   = CGPointMake(recognizer.view.center.x + translation.x,
                                      recognizer.view.center.y + translation.y);
    // 限制屏幕范围：
    newCenter.y = MAX(recognizer.view.frame.size.height/2, newCenter.y);
    newCenter.y = MIN(self.view.frame.size.height - recognizer.view.frame.size.height/2, newCenter.y);
    newCenter.x = MAX(recognizer.view.frame.size.width/2, newCenter.x);
    newCenter.x = MIN(self.view.frame.size.width - recognizer.view.frame.size.width/2,newCenter.x);
    recognizer.view.center = newCenter;
    [recognizer setTranslation:CGPointZero inView:self.view];
    
}

-(void)presentBtnClicked{
    
    YMCircleToViewController *  vc =[[YMCircleToViewController alloc]init];
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)backClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [YMCircleAnimation new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [YMCircleAnimation new];
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
