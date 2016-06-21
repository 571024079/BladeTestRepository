//
//  ViewController.m
//  掌握-RunLoop应用场景
//
//  Created by Handlecar on 16/6/21.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 子线程 */
@property (nonatomic, strong) NSThread *thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     自动释放池什么时候创建和释放
     1.第一次创建, 是在runloop进入的时候创建  对应的状态 = kCFRunLoopEntry
     2.最后一次释放, 是在runloop退出的时候  对应的装 = kCFRunLoopExit
     3.其它创建和释放
     * 每次睡觉的时候都会释放前自动释放池, 然后再创建一个新的
     
     _wrapRunLoopWithAutoreleasePoolHandler activities = 0x1,
     1  = kCFRunLoopEntry  进入loop  创建自动释放池
     
     _wrapRunLoopWithAutoreleasePoolHandler activities = 0xa0,
     160 = kCFRunLoopBeforeWaiting  即将进入睡眠 ,先释放上一次创建的自动释放池, 然后再创建一个新的释放池
     +
     kCFRunLoopExit 即将退出loop  释放自动释放池
     
     */
    NSLog(@"%@", [NSRunLoop currentRunLoop]);
    //    NSLog(@"%d %d", 0x1, 0xa0);
    
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(show) object:nil];
    self.thread = thread;
    [thread start];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __func__);
    /*
     // 1.在指定模式下进行特定的操作
     [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"abc"] afterDelay:2.0 inModes:@[UITrackingRunLoopMode]];
     */
    
    // 默认清空下一个线程只能使用一次, 也就是说只能执行一个操作, 执行完毕之后就不能使用了
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)show{
    NSLog(@"%s", __func__);
    //    while(1);
    
    // 1.子线程的NSRunLoop需要手动创建
    // 2.子线程的NSRunLoop需要手动开启
    // 3.如果子线程的NSRunLoop没有设置source or timer, 那么子线程的NSRunLoop会立刻关闭
    //    [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    
    
    //    NSTimer *timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    //    [[NSRunLoop currentRunLoop] run];
    
    
    // 注意点: NSRunLoop只会检查有没有source和timer, 没有就关闭, 不会检查observer
    CFRunLoopObserverRef  observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    // 释放对象
    CFRelease(observer);
    
    [[NSRunLoop currentRunLoop] run];
    NSLog(@"end -----");
}

- (void)test
{
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
}
@end
