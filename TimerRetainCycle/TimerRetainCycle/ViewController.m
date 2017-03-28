//
//  ViewController.m
//  TimerRetainCycle
//
//  Created by Handlecar on 2017/3/24.
//  Copyright © 2017年 Han Dou. All rights reserved.
//

#import "ViewController.h"
#import "PresentViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)buttonClick:(id)sender {
    PresentViewController *pvc = [[PresentViewController alloc] init];
    
    [self presentViewController:pvc animated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
