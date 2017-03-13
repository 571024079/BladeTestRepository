//
//  OtherViewController.m
//  AppFloatingView
//
//  Created by Handlecar on 2017/3/13.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "OtherViewController.h"
#import "AppDelegate.h"
#import "HDFloatingView.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    HDFloatingView *view = [HDFloatingView floatingViewWithFrame:CGRectMake(0, 300, 100, 100) image:[UIImage imageNamed:@"icon.png"]];
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
