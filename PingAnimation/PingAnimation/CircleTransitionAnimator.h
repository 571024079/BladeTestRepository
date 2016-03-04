//
//  CircleTransitionAnimator.h
//  PingAnimation
//
//  Created by Handlecar on 3/4/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CircleTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitonContext;
@end
