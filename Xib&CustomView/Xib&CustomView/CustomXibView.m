//
//  CustomXibView.m
//  Xib&CustomView
//
//  Created by Handlecar on 2017/3/6.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "CustomXibView.h"

@implementation CustomXibView

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"加载了customXibView");
    
    self.backgroundColor = [UIColor cyanColor];
}

@end
