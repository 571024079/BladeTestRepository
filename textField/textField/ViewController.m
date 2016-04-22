//
//  ViewController.m
//  textField
//
//  Created by Handlecar on 4/21/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _textField.textAlignment = NSTextAlignmentCenter;
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:10];
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 5.0f;
    self.scrollView.minimumZoomScale = 1.0f;
    self.scrollView.multipleTouchEnabled = YES;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
