//
//  WorkOrderDelegate.h
//  Protocol
//
//  Created by Ais on 2017/3/11.
//  Copyright © 2017年 Ais. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WorkOrderDelegate <NSObject>

@property(strong, nonatomic) NSNumber *orderid;

- (void)orderTotalPrice;

@end