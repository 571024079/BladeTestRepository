//
//  HDStaticViewScaleViewController.m
//  ScaleViewDemo
//
//  Created by Handlecar on 16/7/11.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import "HDStaticViewScaleViewController.h"

@interface HDStaticViewScaleViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation HDStaticViewScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 3.0f;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
