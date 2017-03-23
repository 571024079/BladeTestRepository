//
//  ViewController.m
//  NavigationAnimation
//
//  Created by Ais on 2017/3/18.
//  Copyright © 2017年 Ais. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PreViewViewController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"集合";
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectioncell"];
}

#pragma mark - collection view delegate & data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PreViewViewController *pvc = [PreViewViewController new];
    self.currentIndexPath = indexPath;
    self.navigationController.delegate = pvc;
    [self.navigationController pushViewController:pvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
