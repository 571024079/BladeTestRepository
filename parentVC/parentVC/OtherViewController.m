//
//  OtherViewController.m
//  parentVC
//
//  Created by Handlecar on 3/9/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blueColor];
    NSLog(@"presentingViewController %@",self.presentingViewController);
    NSLog(@"modalViewController%@",self.modalViewController);
    NSLog(@"presentedViewController%@",self.presentedViewController);
    NSLog(@"presentingViewController%@",self.presentingViewController);

    
    /*
     @property(nullable,nonatomic,weak,readonly) UIViewController *parentViewController;
     
     // This property has been replaced by presentedViewController.
     @property(nullable, nonatomic,readonly) UIViewController *modalViewController NS_DEPRECATED_IOS(2_0, 6_0) __TVOS_PROHIBITED;
     
     // The view controller that was presented by this view controller or its nearest ancestor.
     @property(nullable, nonatomic,readonly) UIViewController *presentedViewController  NS_AVAILABLE_IOS(5_0);
     
     // The view controller that presented this view controller (or its farthest ancestor.)
     @property(nullable, nonatomic,readonly) UIViewController *presentingViewController NS_AVAILABLE_IOS(5_0);

     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
