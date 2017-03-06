//
//  ViewController.m
//  Motion
//
//  Created by Handlecar on 2017/3/1.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
{
    NSTimer *_timer;
}
@property (weak, nonatomic) IBOutlet UIView *motionView;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic) BOOL isTransform;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _motionManager = [[CMMotionManager alloc] init];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startMotionManager) userInfo:nil repeats:YES];

}

- (void)startMotionManager
{
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    _motionManager.deviceMotionUpdateInterval = 1/15.0;
    if (_motionManager.deviceMotionAvailable) {
        //        NSLog(@"Device Motion Available");
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                            withHandler: ^(CMDeviceMotion *motion, NSError *error){
                                                [self performSelectorOnMainThread:@selector(handleDeviceMotion:) withObject:motion waitUntilDone:YES];
                                                
                                            }];
    } else {
        [self setMotionManager:nil];
    }
}
- (void)handleDeviceMotion:(CMDeviceMotion *)deviceMotion{
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    if (fabs(y) >= fabs(x))
    {
        if(_isTransform){
            [UIView animateWithDuration:0.5 animations:^{
                _motionView.transform = CGAffineTransformMakeRotation(0);
            } completion:^(BOOL finished) {
                _isTransform = NO;
            }];
        }
    }
    else
    {
        if(!_isTransform){
            [UIView animateWithDuration:0.5 animations:^{
                _motionView.transform = CGAffineTransformMakeRotation(M_PI/2);
            } completion:^(BOOL finished) {
                _isTransform = YES;
            }];
        }
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
