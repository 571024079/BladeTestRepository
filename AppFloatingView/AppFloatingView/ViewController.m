//
//  ViewController.m
//  AppFloatingView
//
//  Created by Handlecar on 2017/3/13.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"
#import "HDFloatingView.h"
#import "OtherViewController.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    
//    HDFloatingView *view = [HDFloatingView floatingViewWithFrame:CGRectMake(0, 0, 100, 100) image:[UIImage imageNamed:@"icon.png"]];
//    
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    UIWindow *window = delegate.window;
//    [window addSubview:view];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"present" forState:UIControlStateNormal];
    button.frame = CGRectMake(200, 200, 100, 50);
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *window = delegate.window;
    NSLog(@"%s window subViews count %ld",__func__,window.subviews.count);
}

// 执行viewDidAppear的时候才会添加并显示到window;
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *window = delegate.window;
    NSLog(@"%s window subViews count %ld",__func__,window.subviews.count);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *window = delegate.window;
    NSLog(@"%s window subViews count %ld",__func__,window.subviews.count);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *window = delegate.window;
    NSLog(@"%s window subViews count %ld",__func__,window.subviews.count);
}

- (IBAction)presentAction:(id)sender {
    OtherViewController *otherViewController = [[OtherViewController alloc] init];
    [self.navigationController pushViewController:otherViewController animated:YES];
//    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:otherViewController];
//    [self presentViewController:otherViewController animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
