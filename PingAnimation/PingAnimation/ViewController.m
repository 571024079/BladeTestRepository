//
//  ViewController.m
//  PingAnimation
//
//  Created by Handlecar on 3/4/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
