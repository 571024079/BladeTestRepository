//
//  HDCameraMaskView.h
//  AVCaptureDemo
//
//  Created by Handlecar on 2017/3/8.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDSquare.h"

@interface HDCameraMaskView : UIView

@property (nonatomic, strong) HDSquare *maskFrame;
@property (nonatomic, weak) UILabel *resultLabel;
@property (nonatomic, weak) UIImageView *resultImageView;
@property (nonatomic, weak) UIView *centerView;
@property (weak ,nonatomic) UILabel *promptLabel;

@end
