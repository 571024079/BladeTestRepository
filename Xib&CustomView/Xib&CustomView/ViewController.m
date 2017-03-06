//
//  ViewController.m
//  Xib&CustomView
//
//  Created by Handlecar on 2017/3/6.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"
#import "CustomXibView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CustomXibView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomXibView *view = [[[NSBundle mainBundle] loadNibNamed:@"CustomXibView" owner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor blackColor];
    
    self.customView = view;
    self.customView.backgroundColor = [UIColor blackColor];
    
    CustomXibView *customView = [self.view viewWithTag:999];
    customView.backgroundColor = [UIColor redColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCustomView:(CustomXibView *)customView
{
    _customView = customView;
}

@end
