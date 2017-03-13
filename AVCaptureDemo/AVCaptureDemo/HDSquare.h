//
//  HDSquare.h
//  AVCaptureDemo
//
//  Created by Handlecar on 2017/3/8.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface HDSquare : NSObject

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGRect frame;
@property (nonatomic) CGRect bounds;
@property (nonatomic) CGRect scaleBounds;
@end
