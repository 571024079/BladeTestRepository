//
//  ViewController.m
//  GCD
//
//  Created by Handlecar on 16/3/1.
//  Copyright © 2016年 Handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *iamgeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _iamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _iamgeView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_iamgeView];
    [self dispatchGroup];
}



- (void)descriptionGCD
{
    // Concurrent dispatch queue
    // 并发队列
    // 可以让多个任务并发执行 （自动开启多个线程同时执行任务）
    // 并发功能只有在异步（dispatch_async)函数下才有效，因为只有异步函数才具有开启新线程的能力，而同步函数只能在当前线程执行不具备开启线程的能力
    // 手动创建并发队列
    // 队列名称
    dispatch_queue_t queue = dispatch_queue_create("my dispatch", DISPATCH_QUEUE_CONCURRENT);
    
    // GCD 全局并发队列
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 串行队列
    // serial dispatch queue
    // 使用sync函数往当前串行队列中添加任务，会卡住当前的串行队列
    
    // 创建 串行队列
    dispatch_queue_t serial = dispatch_queue_create("serial dispatch", DISPATCH_QUEUE_SERIAL);
    // 主队列也是一种特殊的串行队列
    dispatch_queue_t mainDispatch = dispatch_get_main_queue();
}

/*
    在子线程中调用 同步函数 + 主队列
*/

- (void)syncMain2
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        // block 会在子线程中执行
        NSLog(@"%@",[NSThread currentThread]);
        dispatch_queue_t queue = dispatch_get_main_queue();
        dispatch_sync(queue, ^{
           // block 一定会在主线程中执行
            NSLog(@"主线程 %@",[NSThread currentThread]);
        });
    });
    NSLog(@"------------");
}

/*
    如果是在主线程中调用同步函数 + 主队列，那么会导致死锁
    导致死锁的原因：
    sync 函数是在主线程中执行的，并且会等待block执行完毕，再调用
    block 也是添加到主队列的，也需要在主线程执行完成之后再调用
*/
- (void)syncMain
{
    NSLog(@"%@",[NSThread currentThread]);
    // 主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    queue = dispatch_queue_create("custom", NULL);
    // 如果是调用 同步函数，那么会等待同步函数中的任务执行完毕，才会执行后面的代码
    // 注意：如果 dispatch_sync方法是在主线程中调用的，并且传入的队列是主队列，那么会导致死锁
    dispatch_sync(queue, ^{
        NSLog(@"-------------");
        NSLog(@"%@",[NSThread currentThread]);
        // 在同步线程中 添加同步任务
        dispatch_sync(queue, ^{
            NSLog(@"在同一个同步线程中执行，调用同步函数");
        });
    });
    NSLog(@"___________");
    // dispatch_sync
    // 在一个同步函数中 block中（执行函数）,再次使用同一个串行队列 调用 同步函数 也会造成死锁
}

/*
 异步 + 主队列 ： 不会创建新的线程，并且任务是在主线程中执行的
*/

- (void)asyncMain
{
    // 主队列
    // 特点：只要将任务添加到主队列中，那么任务一定会在主线程中执行
    // 无论你调用的是同步函数韩式异步函数
    dispatch_queue_t queue = dispatch_get_main_queue();
     dispatch_async(queue, ^{
         NSLog(@"%@",[NSThread currentThread]);
     });
}

/*
    同步 + 并发： 不会开启新的线程
    妻管严
*/

- (void)syncConCurrent
{
    // 1.创建一个并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.将任务添加到队列中
    dispatch_sync(queue, ^{
        NSLog(@"任务1 == %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2 == %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3 == %@",[NSThread currentThread]);
    });
    NSLog(@"----------");
}

/*
    同步 + 串行 : 不会开启新的线程
    注意点：如果是调用 同步函数，那么会等待同步函数中的任务执行完毕，才会执行后面的代码
 */

- (void)syncSerial
{
    // 1.创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("serial", NULL);
    
    // 将任务添加到队列
    dispatch_sync(queue, ^{
        NSLog(@"任务1 == %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2 == %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3 == %@",[NSThread currentThread]);
    });
    NSLog(@"----------");
}

/*
    异步 + 串行：会开启新的线程，但是只会开启一个新的线程
    注意：如果调用异步函数，那么不用等到函数中的任务执行完毕，就会执行后面的代码
 */


- (void)asyncSerial
{
    // 创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("my", DISPATCH_QUEUE_SERIAL);
    /*
     能够创建新线程的原因：我们是使用异步函数调用
     只创建一个子线程的原因：
     我的队列是串行队列
     */
    // 2.将任务添加到队列中
    dispatch_async(queue, ^{
        NSLog(@"任务1 == %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2 == %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3 == %@",[NSThread currentThread]);
    });
    NSLog(@"----------");
}

/*
    异步+并发：会开启新的线程
 如果任务比较多，那么就会开启多个线程
 */
- (void)asyncConcurrent
{
    /*
     异步执行函数
     dispatch_async
     同步执行函数
     dipatch_sync
     */
    
    /*
     第一个参数：队列的名称
     第二个参数:告诉系统需要创建一个并发队列还是串行队列
     DISPATCH_QUEUE_SERIAL :串行
     DISPATCH_QUEUE_CONCURRENT:并发
     */
//    dispatch_queue_t queue = dispatch_queue_create("queue name", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue = dispatch_queue_create("queue name", DISPATCH_QUEUE_SERIAL);
    
    
    // 系统内部已经给我们提供好了一个现成的并发队列
    /*
     第一个参数：iOS8以前是优先级，iOS以后是服务质量
     iOS8以前：
     * - DISPATCH_QUEUE_PRIORITY_HIGH               高优先级     2
     * - DISPATCH_QUEUE_PRIORITY_DEFAULT            默认优先级   0
     * - DISPATCH_QUEUE_PRIORITY_LOW                低优先级    -2
     * - DISPATCH_QUEUE_PRIORITY_BACKGROUND         INT16_MIN         -32768
     IOS8以后：
     * - QOS_CLASS_USER_INTERACTIVE         0X21  用户交互（用户迫切想执行的任务）
     * - QOS_CLASS_USER_INITIATED           0X19  用户需要
     * - QOS_CLASS_DEFAULT                  0X15  默认
     * - QOS_CLASS_UTILITY                  0X11  工具（低优先级，苹果推荐将耗时的操作放到这种类型的队列中）
     * - QOS_CLASS_BACKGROUND               0X09  后台
     * - QOS_CLASS_UNSPECIFIED              0X00  没有设置
     
     第二个参数：待定，暂时没用
     */
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    /*
     第一个参数：用于存放任务的队列
     第二个参数：任务(block)
     
     GCD从队列中取出任务，遵循FIFO原则，先进先出
     输出的结果和苹果所说的原则不符合的原因：CPU可能会有限调度其他的线程
     
     能够创建新线程的原因：
     我们使用的是“异步”函数调用
     能够创建多个子线程的原因：
     我们的队列是并发队列
     */
    dispatch_sync(queue, ^{
        NSLog(@"任务1 == %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2 == %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3 == %@",[NSThread currentThread]);
    });
    NSLog(@"----------");
}

#pragma mark 线程间的通信
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"--------");
    // 1.除主队列外随便搞一个队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 2.调用异步函数
    dispatch_async(queue, ^{
       // 1.下载图片
        NSURL *url = [NSURL URLWithString:@"http://pic.4j4j.cn/upload/pic/20130531/07ed5ea485.jpg"];
        NSError *error;
        NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedAlways error:&error];
        NSLog(@"error : %@",error.localizedDescription);
        // 将二进制转化为图片
        UIImage *image = [UIImage imageWithData:data];
        // 回到主线程更新UI
        /*
            如果想等UI更新完毕再执行后面的代码，那么使用同步函数
            如果不想等UI更新完毕就需要执行后面的代码，那么使用异步函数
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iamgeView.image = image;
        });
        NSLog(@"图片设置完毕");
    });
}
#pragma mark 延时执行
- (void)delayPerform
{
    // iOS常见的延时执行，调用NSObject的方法
    // performSelector 不会阻塞当前线程
    [self performSelector:@selector(run) withObject:nil afterDelay:2];
    // 使用 GCD 函数
    // 该方法中，会根据传入的队列来决定回调block在哪个线程中执行
    // 如果传入的是主队列，那么block会在主线程调用
    // 如果传入的是全局队列，那么block就会在子线程中调用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        NSLog(@"3秒后执行");
    });
}

- (void)run
{
    NSLog(@"2秒后执行");

}

#pragma mark 一次性代码
- (void)onceCode
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"一次性代码");
    });
}

#pragma mark 快速迭代
- (void)fastEnum
{
    /*
     第一个参数：需要遍历几次
     第二个参数：决定第三个参数的block在哪个线程中执行 第二个参数是执行队列
     第三个参数: 回调
     */
    size_t n = 100;
    dispatch_apply(n, dispatch_get_global_queue(0, 0), ^(size_t index) {
        // 执行 n次，index顺序不定
        NSLog(@"%zu",index);
    });
    NSLog(@"------------");
}

#pragma mark 栅栏

- (void)barrier
{
    // 功能：
    // 拦截前面的任务，只有先添加到队列的中的任务执行完毕，才会执行栅栏添加的任务
    // 如果栅栏后面还有任务，那么必须等待栅栏执行完毕才会执行后面的其他任务
    // 注意点：
    // 如果想使用栅栏，那么就不能使用全局的并发队列
    // 如果想使用栅栏，那么所有的任务都必须添加到同一队列中
    
    // 实例合成两种图片，异步函数并发队列多线程下载图片，多个线程同时下载图片，当两种图片下载完毕，开启栅栏功能子线程进行合并图片，合并图片结束后再回到主线程更新UI
    dispatch_queue_t queue = dispatch_queue_create("cjp", DISPATCH_QUEUE_CONCURRENT);
    
   
    __block UIImage *image1 = nil;
    __block UIImage *image2 = nil;
    // 开启一个新的线程下载第一张图片
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://img.alicdn.com/tps/i1/TB1AE.sFVXXXXaCXFXXwu0bFXXX.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        image1 = image;
        NSLog(@"图片1下次完毕");
    });
    // 开启一个新的线程下载第二张图片
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/img/bd_logo1.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        image2 = image;
        NSLog(@"图片1下次完毕");
    });

    // 开启一个新的线程合成图片
    dispatch_barrier_async(queue, ^{
        // 图片下载完毕
        NSLog(@"iamge1%@ ,image2%@",image1,image2);
        // 开启图片上下文
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        // 将第一张图片画上去
        [image1 drawInRect:CGRectMake(0, 0, 100, 200)];
        // 将第二张图片画上去
        [image2 drawInRect:CGRectMake(100, 0, 100, 200)];
        // 从上下文中获取绘制好的图片
        UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
    
        // 回到主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iamgeView.image = newimage;
            // 将合并后的图片写到本地桌面；
            [UIImagePNGRepresentation(newimage) writeToFile:@"/Users/Handlecar/Desktop/123.png" atomically:YES];
        });
        NSLog(@"栅栏执行完毕了");
    });
    dispatch_async(queue, ^{
        NSLog(@"栅栏完成1-----------------");
    });
    dispatch_async(queue, ^{
        NSLog(@"栅栏完成2-----------------");
    });
    dispatch_async(queue, ^{
        NSLog(@"栅栏完成3-----------------");
    });
}

#pragma mark  队列组 dispatch_group_t
// 应用场景：分别执行2各耗时的操作，要等2个异步操作都执行完毕回到主线程执行操作
- (void)dispatchGroup
{
    // 可以使用全局的并行队列也可以自己创建并行队列
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_queue_create("cjp", DISPATCH_QUEUE_CONCURRENT);
    __block UIImage *image1 = nil;
    __block UIImage *image2 = nil;
    dispatch_group_async(group,queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://img.alicdn.com/tps/i1/TB1AE.sFVXXXXaCXFXXwu0bFXXX.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        image1 = image;
        NSLog(@"图片1下次完毕");
    });
    dispatch_group_async(group, queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/img/bd_logo1.png"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        image2 = image;
        NSLog(@"图片2下次完毕");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(),^{
        // 图片下载完毕
        NSLog(@"iamge1%@ ,image2%@",image1,image2);
        // 开启图片上下文
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        // 将第一张图片画上去
        [image1 drawInRect:CGRectMake(0, 0, 100, 200)];
        // 将第二张图片画上去
        [image2 drawInRect:CGRectMake(100, 0, 100, 200)];
        // 从上下文中获取绘制好的图片
        UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
        
        // 回到主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iamgeView.image = newimage;
            // 将合并后的图片写到本地桌面；
            [UIImagePNGRepresentation(newimage) writeToFile:@"/Users/Handlecar/Desktop/123.png" atomically:YES];
        });
        NSLog(@"栅栏执行完毕了");
    });
}

@end
