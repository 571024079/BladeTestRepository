//
//  ViewController.h
//  NavigationAnimation
//
//  Created by Ais on 2017/3/18.
//  Copyright © 2017年 Ais. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

