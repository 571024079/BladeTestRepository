//
//  ViewController.m
//  Emitter
//
//  Created by Handlecar on 16/7/26.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view, typically from a nib.
    CAEmitterLayer* emiiter = [CAEmitterLayer layer];
    emiiter.frame = CGRectMake(0, 100, self.view.bounds.size.width, 100);
    emiiter.backgroundColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:emiiter];
    /*
     CA_EXTERN NSString * const kCAEmitterLayerPoint
     __OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);
     CA_EXTERN NSString * const kCAEmitterLayerLine
     __OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);
     CA_EXTERN NSString * const kCAEmitterLayerRectangle
     __OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);
     CA_EXTERN NSString * const kCAEmitterLayerCuboid
     __OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);
     CA_EXTERN NSString * const kCAEmitterLayerCircle
     __OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);
     CA_EXTERN NSString * const kCAEmitterLayerSphere
     __OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);

     */
    emiiter.emitterShape = kCAEmitterLayerPoint;
    // 设置位置大小
    emiiter.emitterPosition = CGPointMake(self.view.bounds.size.width / 2, 100 / 2);
    emiiter.emitterSize = emiiter.bounds.size;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    view.backgroundColor = [UIColor whiteColor];
    
    // 
    UIGraphicsBeginImageContext(view.bounds.size);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
//    UIImageWriteToSavedPhotosAlbum(image,self, nil, nil);
    CAEmitterCell* cell = [CAEmitterCell emitterCell];
    cell.contents = (__bridge id _Nullable)(image.CGImage);
    
    // 每秒出现的cell
    cell.birthRate = 250;
    cell.lifetime = 4;
    // x y 轴的加速度
    cell.yAcceleration = 70.0;
    cell.xAcceleration = 40.0;
    // 初始速度
    cell.velocity = 20.0;
    // 发射角度
    cell.emissionLatitude = (-M_PI);
    cell.emissionRange = (M_PI_2);

    emiiter.emitterCells = @[cell];
    cell.velocityRange = 200.0;
    
    cell.lifetimeRange = 18;
    cell.redRange = 0.3;
    cell.greenRange = 0.3;
    cell.blueRange = 0.3;
    // 随机大小
    cell.scaleRange = 0.8;
    // 每秒缩小15%
    cell.scaleSpeed = -0.05;
    
    cell.alphaRange = 0.75;
    cell.alphaSpeed = -0.15;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
