//
//  ViewController.m
//  layerposition
//
//  Created by Handlecar on 3/10/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 200, 100, 100);
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSLog(@"button positon:%f.%f",button.layer.position.x,button.layer.position.y);
    CGPoint position = button.layer.position;
    button.layer.position = CGPointMake(position.x + 10, position.y+10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
