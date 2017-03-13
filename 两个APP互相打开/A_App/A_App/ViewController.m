//
//  ViewController.m
//  A_App
//
//  Created by Handlecar on 2017/3/7.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeToAPPB:(id)sender {
    NSURL *url = [NSURL URLWithString:@"APPB://?token=123abct&registered=1"];
    if([[UIApplication sharedApplication] canOpenURL:url])
    {
        NSLog(@"不能打开");
    }
    
    [[UIApplication sharedApplication] openURL:url options:@{@"key":@222} completionHandler:^(BOOL success) {
        NSLog(@"已经打开");
    }];
}


@end
