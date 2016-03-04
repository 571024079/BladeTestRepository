//
//  NavigationControllerDelegate.m
//  PingAnimation
//
//  Created by Handlecar on 3/4/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "CircleTransitionAnimator.h"

@implementation NavigationControllerDelegate

//- (instancetype)init
//{
//    self = [super init];
//    
//    if (self) {
//        _cirTrans = [[CircleTransitionAnimator alloc] init];
//    }
//    return self;
//}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return  [[CircleTransitionAnimator alloc] init];
}

@end
