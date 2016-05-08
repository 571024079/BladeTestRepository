//
//  ViewController.m
//  animation
//
//  Created by Handlecar on 4/29/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *animationLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action:(id)sender {
    [self transitionAnimation1:YES];
}

#pragma mark 转场动画
-(void)transitionAnimation:(BOOL)isNext{
    //1.创建转场动画对象
    CATransition *transition = [[CATransition alloc] init];
    //2.设置转场类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    transition.type = @"cube";
    //设置转场方向类型
    if (isNext) {
        transition.subtype = kCATransitionFromRight;
    }else{
        transition.subtype = kCATransitionFromLeft;
    }
    //设置动画时常
    transition.duration = 1.0f;
    //3.设置转场后的新视图添加转场动画
    static NSInteger count = 0;
    _animationLabel.text = [NSString stringWithFormat:@"%ld",count];
    count++;
    [_animationLabel.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

- (void)transitionAnimation1:(BOOL)isNext
{
    UIViewAnimationOptions option;
    if (isNext) {
        option = UIViewAnimationOptionCurveLinear | UIViewAnimationOptionTransitionFlipFromRight;
    } else {
        option = UIViewAnimationOptionCurveLinear | UIViewAnimationOptionTransitionFlipFromLeft;
    }
    [UIView transitionWithView:_animationLabel duration:1.0 options:option animations:^{
        static NSInteger count = 0;
        _animationLabel.text = [NSString stringWithFormat:@"%ld",count];
        count++;
    } completion:nil];
}
#pragma mark 关键帧动画第一种方式
-(void)translationAnimation1{
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //2.设置关键帧,这里有四个关键帧，对于关键帧动画初始值不能省略
    NSValue *key1 = [NSValue valueWithCGPoint:_animationLabel.layer.position];
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(45, 300)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(55, 400)];
    NSArray *values = @[key1,key2,key3,key4];
    keyframeAnimation.values = values;
    //设置其他属性
    keyframeAnimation.duration = 8.0;
    keyframeAnimation.beginTime = CACurrentMediaTime() + 2;//设置延迟2秒执行
    //3.添加动画到图层，添加动画后就会执行动画
    [_animationLabel.layer addAnimation:keyframeAnimation forKey:@"MYKeyframeAnimation_Position1"];
}
#pragma mark 关键帧动画第二种方式
-(void)translationAnimation2{
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //2.设置路径
    //绘制贝塞尔曲线
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _animationLabel.layer.position.x, _animationLabel.layer.position.y);//移动到起始点
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);//绘制二次贝塞尔曲线
    keyframeAnimation.path = path;//设置path属性
    CGPathRelease(path);//释放路径对象
    //设置其他属性
    keyframeAnimation.duration = 8.0;
    keyframeAnimation.beginTime = CACurrentMediaTime() + 2;//设置延迟2秒执行
    //3.添加动画到图层，添加动画后就会执行动画
    [_animationLabel.layer addAnimation:keyframeAnimation forKey:@"MYKeyframeAnimation_Position2"];
}
-(void)translatonAnimation:(CGPoint)location{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    //2.设置动画属性初始值和结束值
    basicAnimation.fromValue = [NSValue valueWithCGPoint:CGPointZero];
    basicAnimation.toValue = [NSValue valueWithCGPoint:location];
    //设置其他动画属性
    basicAnimation.delegate = self;//设置代理
    basicAnimation.duration = 3.0;//动画时间3秒
    //basicAnimation.repeatCount = HUGE_VALF;//设置重复次数,HUGE_VALF可看做无穷大
    //basicAnimation.removedOnCompletion = NO;//运行一次是否移除动画
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_animationLabel.layer addAnimation:basicAnimation forKey:@"MYBasicAnimation_Translation"];
}
#pragma mark - 动画代理方法
#pragma mark 动画开始
-(void)animationDidStart:(CAAnimation *)anim{
    if( [anim isKindOfClass:[CABasicAnimation class]] ) {
        CABasicAnimation *baseAnima = (CABasicAnimation *)anim;
        //使用key-value的方式保持终点位置坐标
        [baseAnima setValue:baseAnima.toValue forKey:@"MTBasicAnimationLocation"];
    }
}
#pragma mark 动画结束
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if( flag ) {
        //取出终点位置坐标，进行设置
        _animationLabel.layer.position = [[anim valueForKey:@"MTBasicAnimationLocation"] CGPointValue];
    }
}
#pragma mark 旋转动画
-(void)rotationAnimation{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //2.设置动画属性初始值、结束值
    basicAnimation.fromValue = [NSNumber numberWithFloat:M_PI_2];
    basicAnimation.toValue = [NSNumber numberWithFloat:M_PI_2*3];
    //设置其他动画属性
    basicAnimation.duration = 6.0;
    basicAnimation.autoreverses = true;//旋转后再旋转到原来的位置
    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_animationLabel.layer addAnimation:basicAnimation forKey:@"MYBasicAnimation_Rotation"];
}
@end
