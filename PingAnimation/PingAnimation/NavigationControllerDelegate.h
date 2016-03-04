//
//  NavigationControllerDelegate.h
//  PingAnimation
//
//  Created by Handlecar on 3/4/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CircleTransitionAnimator.h"

@interface NavigationControllerDelegate : NSObject <UINavigationControllerDelegate>
@property (nonatomic, strong) CircleTransitionAnimator *cirTrans;
@property (nonatomic, weak) IBOutlet UINavigationController *navigationController;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@end
