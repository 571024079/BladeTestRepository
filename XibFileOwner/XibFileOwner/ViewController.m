//
//  ViewController.m
//  XibFileOwner
//
//  Created by Handlecar on 2017/3/6.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import "FileOwner.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FileOwner *fileOwner  = [FileOwner new];
    CustomView *view = [[[NSBundle mainBundle] loadNibNamed:@"Custom" owner:fileOwner options:nil] firstObject];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
