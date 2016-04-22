//
//  ViewController.m
//  部分圆角
//
//  Created by Handlecar on 4/13/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    label.backgroundColor = [UIColor redColor];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:label.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *shap = [[CAShapeLayer alloc] init];
    [shap setPath:path.CGPath];
    [self.view addSubview:label];
    
    self.view.backgroundColor = [UIColor greenColor];
    label.layer.mask = shap;
    
    UIScrollView *scro;
    scro.contentInset
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
