//
//  ViewController.m
//  MutipleAccessView
//
//  Created by Handlecar on 2017/2/17.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"
#import "MutipleTextFieldAccessView.h"
#import "HDLinkageTextEditor.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.textField.inputAccessoryView = [MutipleTextFieldAccessView accessViewWithTextFieldCount:@5 textLengthLimit:@3 title:@"编号" hostTextField:self.textField];
//    
//    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(100, 100, 100, 30);
//    [button setBackgroundColor:[UIColor redColor]];
//    
//    [button becomeFirstResponder];
//    
//    [self.view addSubview:button];
    HDLinkageTextEditor *linkAge = [HDLinkageTextEditor linkageTextEditorWithTextParts:4 borderStyle:UITextBorderStyleRoundedRect textLengthLimit:3 frame:CGRectMake(100, 100, 154, 27)];
//    linkAge.frame = CGRectMake(100, 100, 300, 40);
    linkAge.backgroundColor = [UIColor blueColor];
    [self.view addSubview:linkAge];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    [self.textField.inputAccessoryView endEditing:YES];
}

@end
