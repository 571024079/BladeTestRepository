//
//  ViewController.m
//  PrintWeb
//
//  Created by Ais on 2017/3/4.
//  Copyright © 2017年 Ais. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *markString;
@property (nonatomic, copy) NSString *printerName;
@property (nonatomic,copy) NSURL *printerURL;
@property (nonatomic, strong) UIPrinter *printer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.webView.delegate = self;
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://news.baidu.com"]];
    [self.webView loadRequest:request];
}

- (IBAction)printAction:(id)sender {
    [self selectPrinterToPrinterWithView:nil copies:nil printPDFData:nil];
}

- (void)printWeb
{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = @"打印，打印";
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    pic.printInfo = printInfo;

    
    
    UIViewPrintFormatter *text = [self.webView viewPrintFormatter];
    
    pic.printFormatter = text;

    self.printer = [UIPrinter printerWithURL:self.printerURL];
    [pic printToPrinter:self.printer completionHandler:^(UIPrintInteractionController * _Nonnull printInteractionController, BOOL completed, NSError * _Nullable error) {
        
        NSLog(@"打印循环完毕");
    }];
    
}

- (void)selectPrinterToPrinterWithView:(UIView *)view copies:(NSInteger)copies printPDFData:(NSData *)myPDFData
{
    UIPrinterPickerController *pickerController =[UIPrinterPickerController printerPickerControllerWithInitiallySelectedPrinter:nil];
    
    CGRect rect;
    //    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    rect = CGRectMake(480, 50, 0, 0);
    [pickerController presentFromRect:rect inView:view animated:YES completionHandler:^(UIPrinterPickerController *controller, BOOL userDidSelect, NSError *err){
        if (userDidSelect)
        {
            // save the urlString and Printer name, do your UI interactions
            self.printerName = controller.selectedPrinter.displayName;
            //            self.submitButton.enabled = YES;
            
            self.printerURL = controller.selectedPrinter.URL;
            
            //            self.airPrinterName = controller.selectedPrinter.displayName;
            NSLog(@"Selected printer:%@", controller.selectedPrinter.displayName);
            [self printWeb];
        }
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *htmlString = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
    self.markString = htmlString;
    NSLog(@"htmlString");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
