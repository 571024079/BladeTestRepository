//
//  ViewController.m
//  ScaleViewDemo
//
//  Created by Handlecar on 16/7/11.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import "ViewController.h"
#import "HDStaticViewScaleViewController.h"
#import "HDInterfaceMixScaleViewController.h"
#import "HDInterfaceScaleViewController.h"
#import "HDMultipleViewController.h"


@interface ViewController ()

@property (nonatomic, strong) UIAlertController *alterVC;
- (IBAction)chooseScaleTypeAction:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:nav];
    
    
    self.alterVC = [self actionInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)chooseScaleTypeAction:(id)sender {
    [self presentViewController:self.alterVC animated:YES completion:nil];
}


- (UIAlertController *)actionInit
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"scaleType" message:@"aa" preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction *acionStatic = [UIAlertAction actionWithTitle:@"static view scale" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        HDStaticViewScaleViewController *vc = [[HDStaticViewScaleViewController alloc] init];
        [strongSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    
    
    UIAlertAction *acionInterface = [UIAlertAction actionWithTitle:@"interface view scale" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        HDInterfaceScaleViewController *vc = [[HDInterfaceScaleViewController alloc] init];
        [strongSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    
    UIAlertAction *acionInterfaceMix = [UIAlertAction actionWithTitle:@"interfaceMix view scale" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        HDInterfaceMixScaleViewController *vc = [[HDInterfaceMixScaleViewController alloc] init];
        [strongSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    
    UIAlertAction *acionMultiple = [UIAlertAction actionWithTitle:@"multipleContent view scale" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        HDMultipleViewController *vc = [[HDMultipleViewController alloc] init];
        [strongSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertVc addAction:acionStatic];
    [alertVc addAction:acionInterface];
    [alertVc addAction:acionInterfaceMix];
    [alertVc addAction:acionMultiple];
    [alertVc addAction:actionCancel];
    return alertVc;
}


@end
