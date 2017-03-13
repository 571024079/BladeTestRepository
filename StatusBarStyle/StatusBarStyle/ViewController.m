//
//  ViewController.m
//  statusBarStyle
//
//  Created by Handlecar on 2017/3/7.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"
#import "PresentViewController.h"
#import "PushViewController.h"
#import "CustomNavigationViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CustomNavigationViewController *nav = [[CustomNavigationViewController alloc] initWithRootViewController:self];
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:nav];
    nav.navigationBar.barStyle = UIBarStyleBlack;
}

- (IBAction)buttonAction:(id)sender {
    PresentViewController *pvc = [PresentViewController new];
    [self.navigationController presentViewController:pvc animated:YES completion:NULL];
}
- (IBAction)pushAction:(id)sender {
    PushViewController *pvc = [PushViewController new];
    [self.navigationController pushViewController:pvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
