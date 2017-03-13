//
//  ViewController.m
//  CollectionViewTextField
//
//  Created by Handlecar on 2017/3/7.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"
#import "PrecheckSubTitleCollectionReusableView.h"
#import "IQKeyboardManager.h"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [IQKeyboardManager sharedManager].enableDebugging = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"PrecheckSubTitleCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"subtitle"];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat width = collectionView.bounds.size.width;
    switch (section) {
        case 0:
            return CGSizeMake(width, 151);
            break;
        case 1:
            return CGSizeMake(width, 151);
            break;
        case 2:
            return CGSizeMake(width, 170);
            break;
        case 3:
            return CGSizeZero;
            break;
        case 4:
            return CGSizeMake(width, 140 );
            break;
        default:
            return CGSizeZero;
            break;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{        PrecheckSubTitleCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"subtitle" forIndexPath:indexPath];
            return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
