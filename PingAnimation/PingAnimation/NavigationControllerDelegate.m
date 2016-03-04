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

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [self.navigationController.view addGestureRecognizer:panGesture];
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
//    return nil;
    return  [[CircleTransitionAnimator alloc] init];
}

- (void)panned:(UIPanGestureRecognizer *)gestureRecogizer
{
    switch (gestureRecogizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
            if (self.navigationController.viewControllers.count > 1)
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self.navigationController.topViewController performSegueWithIdentifier:@"PushSegue" sender:nil];
            }
        }
            break;
         case UIGestureRecognizerStateChanged:
        {
           CGPoint translation = [gestureRecogizer translationInView:self.navigationController.view];
            CGFloat completionProgress = translation.x / CGRectGetWidth(self.navigationController.view.bounds);
            [self.interactionController updateInteractiveTransition:completionProgress];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if ([gestureRecogizer velocityInView:self.navigationController.view].x > 0)
            {
                [self.interactionController finishInteractiveTransition];
            }
            else
            {
                [self.interactionController cancelInteractiveTransition];
            }
            self.interactionController = nil;
        }
            break;
        default:
            [self.interactionController cancelInteractiveTransition];
            self.interactionController = nil;
            break;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}

@end
