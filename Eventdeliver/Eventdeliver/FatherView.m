//
//  FatherView.m
//  Eventdeliver
//
//  Created by Handlecar on 16/6/3.
//  Copyright © 2016年 date. All rights reserved.
//

#import "FatherView.h"

@implementation FatherView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    NSLog(@"");
  UIView * view =  [super hitTest:point withEvent:event];
    return view;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    return YES;
//}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"界面被点击");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"界面被取消点击");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"界面点击结束");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"界面点击移动");
}
@end
