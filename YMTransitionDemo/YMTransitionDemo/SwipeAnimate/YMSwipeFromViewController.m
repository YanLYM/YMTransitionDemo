//
//  YMSwipeFromViewController.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/16.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMSwipeFromViewController.h"
#import "YMSwipeToViewController.h"
#import "YMSwipeTransitionManager.h"

@interface YMSwipeFromViewController ()
@property (nonatomic, strong) YMSwipeTransitionManager *manager;

@end

@implementation YMSwipeFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Swipe";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(event_back)];
    // Do any additional setup after loading the view.
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_present:)];
    gesture.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:gesture];
}
- (void)event_back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)gesture_present:(UIScreenEdgePanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        YMSwipeToViewController *vc = [sb instantiateViewControllerWithIdentifier:@"YMSwipeToViewController"];

        self.manager.gestureRecognizer = gesture;
        self.manager.targetEdge = UIRectEdgeRight;
        vc.transitioningDelegate = self.manager;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }
}
- (IBAction)event_jump:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YMSwipeToViewController *vc = [sb instantiateViewControllerWithIdentifier:@"YMSwipeToViewController"];
    self.manager.gestureRecognizer = nil;
    self.manager.targetEdge = UIRectEdgeRight;
    vc.transitioningDelegate = self.manager;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (YMSwipeTransitionManager *)manager {
    if (nil == _manager) {
        _manager = [YMSwipeTransitionManager new];
    }
    return _manager;
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
