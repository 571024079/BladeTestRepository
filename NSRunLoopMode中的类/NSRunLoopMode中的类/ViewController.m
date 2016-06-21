//
//  ViewController.m
//  NSRunLoopMode中的类
//
//  Created by Handlecar on 16/6/21.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/*时间*/
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __func__);
    [self gcdTimer];
}
- (IBAction)btnClick:(id)sender {
    NSLog(@"%s", __func__);
}
- (void)gcdTimer
{
    /*
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     NSLog(@"-----------");
     });
     */
    
    NSLog(@"%s", __func__);
    // 0.获取一个全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 1.创建一个定时器
    // 第四个参数: 传递一个队列, 该队列对顶了将来的回调方法在哪个线程中执行
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    self.timer = timer;
    //    NSLog(@"%@", timer);
    
    // 2.指定定时器开始的时间和间隔的时间, 以及精准度
    /*
     第1个参数: 需要给哪个定时器设置
     第2个参数: 定时器开始的时间 / DISPATCH_TIME_NOW立即执行
     第3个参数: 定时器开始之后的间隔时间
     第4个参数: 定时器间隔执行的精准度, 传入0代表最精准(尽量的让定时器精准), 传入一个大于0的值, 代表多少秒的范围是可以接受的
     第四个参数存在的意义: 主要是为了提高程序的性能
     注意点: Dispatch的定时器接收的时间是纳秒
     */
    
    // 开始时间
    //    dispatch_time_t startTime = DISPATCH_TIME_NOW;
    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);
    
    // 间隔时间
    uint64_t interval = 1.0 * NSEC_PER_SEC;
    dispatch_source_set_timer(timer, startTime, interval, 0 * NSEC_PER_SEC);
    
    // 3.指定定时器的回调方法
    /*
     第1个参数: 需要给哪个定时器设置
     第2个参数: 需要回调的block
     */
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"++++++++++++++ %@", [NSThread currentThread]);
        
    });
    
    // 4.开启定时器
    dispatch_resume(timer);
}
- (void)timers
{
    /*
     // 1.创建一个NSTimer
     NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(show) userInfo:nil repeats:YES];
     // 2.将NSTimer添加到RunLoop中, 并且告诉系统, 当前Tiemr只有在RunLoop的默认模式下才有效
     //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
     
     // 2.将NSTimer添加到RunLoop中, 并且告诉系统, 当前Tiemr只有在Tracking的默认模式下才有效
     //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
     
     // 2.将NSTimer添加到RunLoop中, 并且告诉系统, 在所有被"标记"common的模式都可以运行
     */
    /*
     common modes = <CFBasicHash 0x7fc0b8615250 [0x104be7180]>{type = mutable set, count = 2,
     entries =>
     0 : <CFString 0x1058bae50 [0x104be7180]>{contents = "UITrackingRunLoopMode"}
     2 : <CFString 0x104bc3080 [0x104be7180]>{contents = "kCFRunLoopDefaultMode"}
     }
     UITrackingRunLoopMode和kCFRunLoopDefaultMode都被标记为了common模式, 所以只需要将timer的模式设置为forMode:NSRunLoopCommonModes, 就可以在默认模式和追踪模式都能够运行
     */
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    // 注意: 如果是通过scheduledTimerWithTimeInterval创建的NSTimer, 默认就会添加到RunLoop得DefaultMode中 , 所以它会自动运行
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(show) userInfo:nil repeats:YES];
    // 虽然默认已经添加到DefaultMode中, 但是我们也可以自己修改它的模式
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


- (void)show
{
    NSLog(@"%s", __func__);
}

@end
