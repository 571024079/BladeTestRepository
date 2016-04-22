//
//  CustomViewController.m
//  navgationController
//
//  Created by Handlecar on 4/20/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.barTintColor = [UIColor colorWithRed:0x22/255.f green:0x22/255.f blue:0x22/255.f alpha:1];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, [UIColor whiteColor],UITextAttributeTextShadowColor,[UIFont fontWithName:@"Heiti SC" size:16.0],UITextAttributeFont,nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
