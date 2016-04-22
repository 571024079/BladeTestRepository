//
//  ViewController.m
//  navgationController
//
//  Created by Handlecar on 4/20/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "ViewController.h"
#import "CustomViewController.h"
#import "OneViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)action:(id)sender {
    
    OneViewController *vc = [[OneViewController alloc] init];
    CustomViewController *nav = [[CustomViewController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
//    [self.parentViewController transitionFromViewController:self toViewController:nav duration:0.1 options:UIViewAnimationOptionCurveEaseIn animations:nil completion:nil];
    
//    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:nav];
}

@end
