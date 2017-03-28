//
//  PreViewViewController.m
//  NavigationAnimation
//
//  Created by Ais on 2017/3/18.
//  Copyright © 2017年 Ais. All rights reserved.
//

#import "PreViewViewController.h"
#import "BNavigationTransition.h"


@interface PreViewViewController ()

@end

@implementation PreViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"图片预览";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush)
    {
        return [BNavigationTransition transitionWithType:BNavigationTransitionTypePush];
    }
    else
    {
        return [BNavigationTransition transitionWithType:BNavigationTransitionTypePop];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
