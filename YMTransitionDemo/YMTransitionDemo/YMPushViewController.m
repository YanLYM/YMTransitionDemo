//
//  YMPushViewController.m
//  YMTransitionDemo
//
//  Created by Max on 2019/1/11.
//  Copyright © 2019年 Max. All rights reserved.
//

#import "YMPushViewController.h"

@interface YMPushViewController ()

@end

@implementation YMPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"PushViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (IBAction)event_dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
