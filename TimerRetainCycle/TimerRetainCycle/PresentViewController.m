//
//  PresentViewController.m
//  TimerRetainCycle
//
//  Created by Handlecar on 2017/3/24.
//  Copyright © 2017年 Han Dou. All rights reserved.
//

#import "PresentViewController.h"

@interface PresentViewController ()
{
    NSTimer *_timer;
}
- (IBAction)buttonAction:(id)sender;

- (void)starPolling;
- (void)stopPolling;
@end

@implementation PresentViewController
- (IBAction)buttonAction:(id)sender {
    [self starPolling];
}

- (void)starPolling
{
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(p_polling) userInfo:nil repeats:YES];
}

- (void)dealloc
{
    [_timer invalidate];
    
    NSLog(@"释放了");
}

- (void)stopPolling
{
    [_timer invalidate];
    _timer = nil;
}

- (void)p_polling
{
    NSLog(@"轮询");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [NSTimer scheduledTimerWithTimeInterval:<#(NSTimeInterval)#> repeats:<#(BOOL)#> block:<#^(NSTimer * _Nonnull timer)block#>]
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
