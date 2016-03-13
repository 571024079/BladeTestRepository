//
//  ViewController.m
//  markViewDemo
//
//  Created by Handlecar on 3/13/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "ViewController.h"
#import "OvalAnnotationView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    OvalAnnotationView *view = [[OvalAnnotationView alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    view.backgroundColor = [UIColor clearColor];
    view.tag = 100;
    [self.view addSubview:view];
    
    OvalAnnotationView *view1 = [[OvalAnnotationView alloc] initWithFrame:CGRectMake(100, 350, 200, 100)];
    [self.view addSubview:view1];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"gggggg" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 450, 200, 200);
    [button addTarget:self action:@selector(changeViewBound:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)changeViewBound:(id)sender
{
    UIView *view = [self.view viewWithTag:100];
    CGRect frame = view.frame;
    frame.size.width += 100;
    view.frame = frame;
    [view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
