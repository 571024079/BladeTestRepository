//
//  CircleTransitionAnimator.m
//  PingAnimation
//
//  Created by Handlecar on 3/4/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "CircleTransitionAnimator.h"

@implementation CircleTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitonContext = transitionContext;
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *fromViewController = transitionContext viewControllerForKey:<#(nonnull NSString *)#>
}

@end
