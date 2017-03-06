//
//  ViewController.m
//  performanceTest
//
//  Created by Handlecar on 2017/3/1.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimeInterval time;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    while (1) {
//        [self add];
//    }
    [self add];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 200, 30);
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(100,200, 200, 30);
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 setTitle:@"按钮" forState:UIControlStateNormal];
    
    [self.view addSubview:button1];
    
    [button1 addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction:(id)sender
{
    // 手动调用函数 直到函数完成 10次数据统计
    /*
     2017-03-01 12:00:28.452 performanceTest[1232:25150] 0.000003
     2017-03-01 12:00:28.839 performanceTest[1232:25150] 0.000004
     2017-03-01 12:00:29.294 performanceTest[1232:25150] 0.000005
     2017-03-01 12:00:29.773 performanceTest[1232:25150] 0.000004
     2017-03-01 12:00:30.367 performanceTest[1232:25150] 0.000003
     2017-03-01 12:00:31.065 performanceTest[1232:25150] 0.000050
     2017-03-01 12:00:31.638 performanceTest[1232:25150] 0.000004
     2017-03-01 12:00:32.197 performanceTest[1232:25150] 0.000005
     2017-03-01 12:00:32.751 performanceTest[1232:25150] 0.000077
     2017-03-01 12:00:33.256 performanceTest[1232:25150] 0.000003
     */
    //平均值为 0.000015.8  通知平均值为0.000048.2  三分之一
    time = [[NSDate date] timeIntervalSinceReferenceDate];
    [self one:nil];
}

- (void)buttonAction1:(id)sender
{
    // 通知调用函数 直到函数完成 10次数据统计
    /*
     2017-03-01 12:02:31.830 performanceTest[1232:25150] 0.000022
     2017-03-01 12:02:32.350 performanceTest[1232:25150] 0.000017
     2017-03-01 12:02:33.092 performanceTest[1232:25150] 0.000024
     2017-03-01 12:02:33.707 performanceTest[1232:25150] 0.000095
     2017-03-01 12:02:34.375 performanceTest[1232:25150] 0.000021
     2017-03-01 12:02:35.053 performanceTest[1232:25150] 0.000070
     2017-03-01 12:02:35.697 performanceTest[1232:25150] 0.000074
     2017-03-01 12:02:36.329 performanceTest[1232:25150] 0.000119
     2017-03-01 12:02:36.989 performanceTest[1232:25150] 0.000020
     2017-03-01 12:02:37.563 performanceTest[1232:25150] 0.000020
     */
    // 平均值 0.000048.2 是手动调用花费时间的3倍 有时候会达到将近6倍或以上，每次通知消耗的时间不是很稳定
    time = [[NSDate date] timeIntervalSinceReferenceDate];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"aaaa" object:nil];
}

- (void)add
{
    time =[[NSDate date] timeIntervalSinceReferenceDate];
//    NSLog(@"%f",time);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(one:) name:@"aaaa" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(one:) name:@"aaaa1" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(one:) name:@"aaaa2" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(one:) name:@"aaaa3" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(one:) name:@"aaaa4" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(one:) name:@"aaaa5" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(one:) name:@"aaaa6" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(one:) name:@"aaaa7" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(one:) name:@"aaaa8" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(one:) name:@"aaaa9" object:nil];
    NSLog(@"%f",[[NSDate date] timeIntervalSinceReferenceDate] - time);
}

- (void)one:(id)not
{
    NSLog(@"%f",[[NSDate date] timeIntervalSinceReferenceDate] - time);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
