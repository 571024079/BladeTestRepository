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

- (void)viewDidLoad {
    [super viewDidLoad];

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
        self.label.text = @"LabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabel";
        
        // label text赋值，文本长的反而消耗的时间短
    }
    NSLog(@"结束");
}


@end
