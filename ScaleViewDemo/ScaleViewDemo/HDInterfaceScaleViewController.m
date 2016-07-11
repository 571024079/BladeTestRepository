//
//  HDInterfaceScaleViewController.m
//  ScaleViewDemo
//
//  Created by Handlecar on 16/7/11.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import "HDInterfaceScaleViewController.h"

@interface HDInterfaceScaleViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)buttonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation HDInterfaceScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 3.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.contentView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //    self.contentView.transform = CGAffineTransformMakeScale(scrollView.zoomScale, scrollView.zoomScale);
    NSLog(@"11111");
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"");
    //    [self.view setNeedsLayout];
}

- (IBAction)buttonAction:(id)sender {
}
@end
