//
//  HDFloatingView.m
//  AppFloatingView
//
//  Created by Handlecar on 2017/3/13.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "HDFloatingView.h"
@interface HDFloatingView()

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation HDFloatingView

+ (HDFloatingView *)floatingViewWithFrame:(CGRect)frame image:(UIImage *)image
{
    HDFloatingView *floatingView = [[HDFloatingView alloc] initWithFrame:frame];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:floatingView.bounds];
    imageView.image = image;
    [floatingView addSubview:imageView];
    
    floatingView.imageView = imageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:floatingView action:@selector(tapAction:)];
    
    [floatingView addGestureRecognizer:tap];
    
    return floatingView;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"tap action");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"touchesBegan");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint movePoint = [touch locationInView:nil];
    
    self.center = movePoint;

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];

}

@end
