//
//  ViewController.m
//  RunLoop
//
//  Created by Handlecar on 16/6/21.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(320, 10000);
    self.scrollView.backgroundColor = [UIColor yellowColor];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
//    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
//    NSLog(@"currentRunLoop = %@",currentRunLoop);
//    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
//    NSLog(@"mainRunLoop = %@",mainRunLoop);
//    
//    CFRunLoopRef currentRunloop = CFRunLoopGetCurrent();
//    NSLog(@"currentRunloop = %@",currentRunloop);
//    CFRunLoopRef mainRunloop = CFRunLoopGetMain();
//    NSLog(@"mainRunloop = %@",mainRunloop);
//    /*
//     1.一条线程对应一个RunLoop
//     2.主线程的RunLoop默认已经创建好了, 而子线程的需要我们自己手动创建
//     3.一个NSRunLoop/CFRunLoopRef, 就代表一个RunLoop对象
//     4.如何获取当前线程对应的RunLoop对象,currentRunLoop/CFRunLoopGetCurrent
//     5.如何获取主线程对应的RunLoop对象,mainRunLoop/CFRunLoopGetMain
//     6.只要线程结束了, 那么与之对应的RunLoop对象也会被释放
//     */
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(show) object:nil];
//    [thread start];
//}
}
- (void)show
{
    //    [[NSRunLoop alloc] init]; // 注意, 如果想给子线程添加RunLoop, 不能直接alloc init

   // 只要调用currentRunLoop方法, 系统就会自动创建一个RunLoop, 添加到当前线程中
    NSLog(@"currentRunloop = %@", [NSRunLoop currentRunLoop]);

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    NSLog(@"currentRunLoop = %@",currentRunLoop);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
