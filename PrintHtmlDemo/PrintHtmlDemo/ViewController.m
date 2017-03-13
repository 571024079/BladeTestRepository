//
//  ViewController.m
//  PrintHtmlDemo
//
//  Created by Handlecar on 2017/3/6.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPrintInteractionControllerDelegate>
@property (nonatomic, strong) UIPrinter *printer;
@property (nonatomic, copy) NSString *printerName;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,copy) NSURL *printerURL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.iqiyi.com/"]];
    [self.webView loadRequest:request];
  
}

- (IBAction)beginPrint:(id)sender {
    UIPrinterPickerController *pickerController =[UIPrinterPickerController printerPickerControllerWithInitiallySelectedPrinter:nil];
    
    CGRect rect;
    //    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    rect = CGRectMake(480, 50, 0, 0);
    [pickerController presentFromRect:rect inView:self.view animated:YES completionHandler:^(UIPrinterPickerController *controller, BOOL userDidSelect, NSError *err){
        if (userDidSelect)
        {
            // save the urlString and Printer name, do your UI interactions
            self.printerName = controller.selectedPrinter.displayName;
            //            self.submitButton.enabled = YES;
            
            self.printerURL = controller.selectedPrinter.URL;
            
            //            self.airPrinterName = controller.selectedPrinter.displayName;
            NSLog(@"Selected printer:%@", controller.selectedPrinter.displayName);
            
            
            
            UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
            pic.delegate = self;
            
            UIPrintInfo *printInfo = [UIPrintInfo printInfo];
            printInfo.outputType = UIPrintInfoOutputGeneral;
            printInfo.jobName = @"打印，打印";
            printInfo.duplex = UIPrintInfoDuplexLongEdge;
            pic.printInfo = printInfo;
            //        pic.showsPageRange = YES;
            UIViewPrintFormatter *printFormatter = [self.webView viewPrintFormatter];
            pic.printFormatter = printFormatter;
            
            //        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
            //        ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
            ////            self.content = nil;
            //            if (!completed && error)
            //                NSLog(@"FAILED! due to error in domain %@ with error code %u",
            //                      error.domain, error.code);
            //        };
            self.printer = [UIPrinter printerWithURL:self.printerURL];
            [pic printToPrinter:self.printer completionHandler:^(UIPrintInteractionController * _Nonnull printInteractionController, BOOL completed, NSError * _Nullable error) {
                
                NSLog(@"打印循环完毕");
            }];

        }
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
