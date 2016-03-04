//
//  CircleTransitionAnimator.m
//  PingAnimation
//
//  Created by Handlecar on 3/4/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "CircleTransitionAnimator.h"

#import "ViewController.h"

@implementation CircleTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitonContext = transitionContext;
    
    UIView *containerView = [transitionContext containerView];
    ViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIButton *button = fromViewController.button;
    
    [containerView addSubview:toViewController.view];
 
    UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    CGPoint extremePoint = CGPointMake(button.center.x, button.center.y - CGRectGetHeight(toViewController.view.bounds));
    
    CGFloat radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y));
    
    UIBezierPath *circleMaskFinal = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = circleMaskFinal.CGPath;
    toViewController.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(circleMaskPathInitial.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(circleMaskFinal.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{

    [self.transitonContext completeTransition:![self.transitonContext transitionWasCancelled]];
    [self.transitonContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
}

@end
