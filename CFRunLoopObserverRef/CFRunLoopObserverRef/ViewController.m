//
//  ViewController.m
//  CFRunLoopObserverRef
//
//  Created by Handlecar on 16/6/21.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建Observer
    /*
     第1个参数: 指定如何给observer分配存储空间
     第2个参数: 需要监听的状态类型/ kCFRunLoopAllActivities监听所有状态
     第3个参数: 是否每次都需要监听
     第4个参数: 优先级
     第5个参数: 监听到状态改变之后的回调
     */
    CFRunLoopObserverRef  observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"即将进入runloop");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"即将处理timer");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"即将处理source");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将进入睡眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"刚从睡眠中唤醒");
                break;
            case kCFRunLoopExit:
                NSLog(@"即将退出");
                break;
            default:
                break;
        }
    });
    
    
    // 给主线程的RunLoop添加一个观察者
    /*
     第1个参数: 需要给哪个RunLoop添加观察者
     第2个参数: 需要添加的Observer对象
     第3个参数: 在哪种模式下可以可以监听
     */
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
    
    // 释放对象
    CFRelease(observer);
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(show) userInfo:nil repeats:YES];
}

- (void)show{
    NSLog(@"show");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
