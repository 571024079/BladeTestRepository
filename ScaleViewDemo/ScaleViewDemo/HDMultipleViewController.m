//
//  HDMultipleViewController.m
//  ScaleViewDemo
//
//  Created by Handlecar on 16/7/11.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import "HDMultipleViewController.h"
#import "HDMultipleCollectionViewCell.h"

@interface HDMultipleViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIView *secondView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation HDMultipleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.collectionView.delegate = self;
    self.collectionView.maximumZoomScale = 3.0f;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HDMultipleCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"reuseStr"];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.collectionView;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(200, 200);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseStr" forIndexPath:indexPath];

    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
