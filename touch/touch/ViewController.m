//
//  ViewController.m
//  touch
//
//  Created by Handlecar on 4/22/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)clickAction:(id)sender {
    NSLog(@"点击按钮事件");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击view");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"移动view");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
