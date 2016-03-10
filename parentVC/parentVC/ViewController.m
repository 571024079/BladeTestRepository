//
//  ViewController.m
//  parentVC
//
//  Created by Handlecar on 3/9/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "ViewController.h"
#import "OtherViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(presentOtherVC:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 100, 100, 50);
    [button setTitle:@"goto" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)presentOtherVC:(id)sender
{
    OtherViewController *vc = [[OtherViewController alloc] init];
    [self presentViewController:vc animated:vc completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
