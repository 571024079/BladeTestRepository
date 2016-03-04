//
//  ViewController.m
//  PingAnimation
//
//  Created by Handlecar on 3/4/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:_button.frame];
//    CGPoint extremePoint = CGPointMake(_button.center.x, _button.center.y - CGRectGetHeight(self.view.bounds));
//    
//    CGFloat radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y));
//    
//    UIBezierPath *circleMaskFinal = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(_button.frame, -radius, -radius)];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectInset(_button.frame, -radius, -radius)];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
    
}
- (IBAction)circleTapAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)pushAction:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
