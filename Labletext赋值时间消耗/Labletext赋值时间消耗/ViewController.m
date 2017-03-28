//
//  ViewController.m
//  Labletext赋值时间消耗
//
//  Created by Handlecar on 2017/3/10.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void (^)(int a))som
{
    
    
    return ^(int a){
        if (a == 1)
        {
            NSLog(@"返回成功");
        }
    };
}



- (void)viewDidLoad {
    [super viewDidLoad];

    void (^block)(int a) = [self som];
    
    block(1);
    
    NSString *abc = @"abc"; // 在栈上分配
    char *s = "abc"; // 栈上
    NSString *aabc = [NSString stringWithString:abc]; // 栈上
    NSString *aaabc = [[NSString alloc] initWithString:abc]; // 栈上
    
    NSLog(@"s %p\n abc %p \n aabc %p \n aaabc %p",s,abc,aabc,aaabc);

    // 执行abc aabc aaabc copy等不可变字符串不会拷贝到堆上
    NSString *copyabc = [@"abc" copy]; // 在栈上分配
    NSString *copyaabc = [[NSString stringWithString:abc] copy]; // 栈上
    NSString *copyaaabc = [[[NSString alloc] initWithString:abc] copy]; // 栈上
    self.label.text = copyaaabc;
    // 对不可变字符串copy不会改变地址
    NSLog(@"s %p\n abc %p \n aabc %p \n aaabc %p \n label text %p",s,copyabc,copyaabc,copyaaabc,self.label.text);

    
    
    
    
    NSMutableString *mstring = [NSMutableString stringWithString:abc];
    
    if ([mstring isEqual:abc])
    {
        // 尽管字符串地址不相等，还是可以比较出两个字符串是否相等的，内部实现对此做了优化，但是我们还是不应该这么做，这样会增加系统类型查询时的消耗。
        NSLog(@"相等");
    }
    
    //text的地址 与 textcopy的地址 一致，对不可变字符串copy，地址是一致的;abc通过可变字符串初始化方法之后，就变成了可变字符串mstring
    NSString *text = [mstring copy]; // 对可变字符串 会拷贝到堆上
    NSString *textCopy = [text copy];
    self.label.text = text; // 这个有点奇怪，label text 的地址 与 text的不一致 与 abc的地址一致 应该是内部有优化，取之前出现过的字符串。
    
    NSLog(@"mstring %p\n label text %p \n text %p \n textcopy %p \n abc %p",mstring,self.label.text,text,textCopy,abc);
    
    // 看一下可变数组与不可变数组是否一致 猜想应该是不一致的，实际上对不可变字符串和数组的copy地址都是不变的
    NSArray *array = @[@1,@"ab23"];
    NSArray *firstCopyArray = [array copy];
    
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:array];
    
    NSArray *copyArray = [mArray copy];
    
    NSArray *copyArray2 = [copyArray copy]; // 对copyArray copy地址还是copyArray的地址
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@2 forKey:abc];
    [dict setObject:@3 forKey:text];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonAction:(id)sender {
    
    NSLog(@"开始");
    for (NSInteger i = 0; i < 1000000; i++) {
        /*
         2017-03-10 12:10:30.096 Labletext赋值时间消耗[2969:36942] 开始
         2017-03-10 12:10:30.200 Labletext赋值时间消耗[2969:36942] 结束
         2017-03-10 12:10:39.968 Labletext赋值时间消耗[2969:36942] 开始
         2017-03-10 12:10:40.069 Labletext赋值时间消耗[2969:36942] 结束
         self.label.text = @"Label";
         */
        
        
        /*
         2017-03-10 12:13:09.569 Labletext赋值时间消耗[3000:38085] 开始
         2017-03-10 12:13:09.643 Labletext赋值时间消耗[3000:38085] 结束
         2017-03-10 12:13:10.279 Labletext赋值时间消耗[3000:38085] 开始
         2017-03-10 12:13:10.351 Labletext赋值时间消耗[3000:38085] 结束
         2017-03-10 12:13:10.939 Labletext赋值时间消耗[3000:38085] 开始
         2017-03-10 12:13:11.013 Labletext赋值时间消耗[3000:38085] 结束
         */
        self.label.text =[NSString stringWithFormat:@"%@%ld", @"LabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabel",i];
        
        // label text赋值，文本长的反而消耗的时间短
    } // runloop处理完当前方法之后才会重绘text
    NSLog(@"结束");
}


@end
