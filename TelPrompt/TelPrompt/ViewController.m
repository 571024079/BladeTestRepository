//
//  ViewController.m
//  TelPrompt
//
//  Created by Handlecar on 5/9/16.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)telPromptAction:(id)sender {
//    NSString *escapedPhoneNumber = [@"18354612212" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",escapedPhoneNumber]]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",@"www.baidu.com"]]];

}
- (IBAction)telAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:18354612212"]];
}

@end
