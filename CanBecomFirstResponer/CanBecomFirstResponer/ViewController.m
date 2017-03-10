//
//  ViewController.m
//  CanBecomFirstResponer
//
//  Created by Handlecar on 2017/3/10.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _textField.delegate = self;
    _textField.enabled = NO;
    NSLog(@"userinterface = %d",_textField.userInteractionEnabled);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setFirstResponer:(id)sender {
    [_textField canBecomeFirstResponder];
}

@end
