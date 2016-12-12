//
//  ViewController.m
//  CollecttionPdfView
//
//  Created by Ais on 2016/12/11.
//  Copyright © 2016年 Ais. All rights reserved.
//

#import "ViewController.h"
#import "TiledPDFView.h"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSUInteger pageCount;
@property CGPDFDocumentRef pdf;
@property int numberOfPages;
@property (nonatomic, strong) NSMutableArray *pdfViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    NSURL *pdfURL = [[NSBundle mainBundle] URLForResource:@"input_pdf.pdf" withExtension:nil];
    self.pdf = CGPDFDocumentCreateWithURL( (__bridge CFURLRef) pdfURL );
    self.numberOfPages = (int)CGPDFDocumentGetNumberOfPages( self.pdf );
    if( self.numberOfPages % 2 ) self.numberOfPages++;

    _pdfViews = [NSMutableArray array];
    
    for (NSInteger i = 0; i < self.numberOfPages; i++)
    {
        TiledPDFView *pdfView = [[TiledPDFView alloc] initWithFrame:CGRectMake(0, 0, 374, 667) scale:0.5];
        pdfView.tag = 100;
        pdfView.pdfPage = CGPDFDocumentGetPage( self.pdf, i + 1 );
        [_pdfViews addObject:pdfView];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberOfPages;//self.pageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor redColor];
    [[cell.contentView viewWithTag:100] removeFromSuperview];

    TiledPDFView *pdfView =  [self.pdfViews objectAtIndex:indexPath.item];
//    [pdfView setNeedsDisplay];
    [cell.contentView addSubview:pdfView];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
