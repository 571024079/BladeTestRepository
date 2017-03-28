//
//  BNavigationTransition.h
//  NavigationAnimation
//
//  Created by Ais on 2017/3/18.
//  Copyright © 2017年 Ais. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BNavigationTransitionType) {
    BNavigationTransitionTypePush,
    BNavigationTransitionTypePop,
};

@interface BNavigationTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithType:(BNavigationTransitionType)transitionType;

- (instancetype)initWithTransitionType:(BNavigationTransitionType)transitionType;

@end
