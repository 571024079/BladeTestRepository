//
//  BNavigationTransition.m
//  NavigationAnimation
//
//  Created by Ais on 2017/3/18.
//  Copyright © 2017年 Ais. All rights reserved.
//

#import "BNavigationTransition.h"
#import "ViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PreViewViewController.h"
@interface BNavigationTransition ()
@property (nonatomic) BNavigationTransitionType transitionType;
@end

@implementation BNavigationTransition

+ (instancetype)transitionWithType:(BNavigationTransitionType)transitionType
{
    return [[self alloc] initWithTransitionType:transitionType];
}


- (instancetype)initWithTransitionType:(BNavigationTransitionType)transitionType
{
    if (self = [super init]) {
        self.transitionType = transitionType;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.transitionType) {
        case BNavigationTransitionTypePush:
        {
            [self pushAnimation:transitionContext];
        }
            break;
        case BNavigationTransitionTypePop:
        {
            [self popAnimation:transitionContext];
        }
            break;
        default:
            break;
    }
}

- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
 
    PhotoCollectionViewCell *fromCell = [fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
    
    UIView *containerView = [transitionContext containerView];
    
    CGFloat imgWidth = 240;
    CGFloat imgHeight = 160;
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.width;
    
    UIImageView *tempView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"123.jpg"]];
    tempView.clipsToBounds = YES;
    tempView.contentMode = UIViewContentModeScaleAspectFill;
    tempView.frame = [fromCell convertRect:fromCell.bounds toView:containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    fromVC.view.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        tempView.frame = CGRectMake(67,  253.5, imgWidth, imgHeight);
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        fromVC.view.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
}

- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    PreViewViewController  *fromVC = (PreViewViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
 
    UIImageView *tempView = [[UIImageView alloc] initWithImage:fromVC.imageView.image];
    tempView.clipsToBounds = YES;
    tempView.contentMode = UIViewContentModeScaleAspectFill;
    tempView.frame = fromVC.imageView.frame;
    
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    
    UIView *containerView = [transitionContext containerView];
    
    [containerView insertSubview:toVC.view atIndex:0];
    [containerView addSubview:tempView];
    
    CGRect rect = [cell convertRect:cell.bounds toView:nil];
    
    cell.hidden = YES;
    fromVC.view.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        tempView.frame = rect;
    } completion:^(BOOL finished) {
        cell.hidden = NO;
        [tempView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
