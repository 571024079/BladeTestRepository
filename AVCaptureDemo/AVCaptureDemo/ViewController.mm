//
//  ViewController.m
//  AVCaptureDemo
//
//  Created by Handlecar on 2017/3/8.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "ViewController.h"
#import "vinTyper.h"
#import "HDCameraMaskView.h"
#import "AppDelegate.h"
@interface ViewController ()<UIAlertViewDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>
{
    AVCaptureSession *_captureSession;
    AVCaptureDeviceInput *_captureInput;
    AVCaptureStillImageOutput *_captureOutput;
    AVCaptureVideoPreviewLayer *_capturePreview;
    AVCaptureDevice *_captureDevice;
    VinTyper *_vinTyper; //识别核心
    BOOL _isCameraAuthor; //是否有打开摄像头权限
    BOOL _isFocusPixels;//是否相位对焦
    BOOL _isFocusing;//是否正在对焦
    GLfloat _FocusPixelsPosition;//相位对焦下镜头位置
    BOOL _isRecognize; //是否识别
    GLfloat _curPosition;//当前镜头位置
    
    CGFloat _widthScale;
    CGFloat _heightScale;
    NSTimer* _timer;
    CGPoint linePoint;//扫描线初始位置
}
@property (weak, nonatomic) IBOutlet HDCameraMaskView *maskView;
@property (weak, nonatomic) IBOutlet UIImageView *scan_line;//扫描线
@property (nonatomic, strong) CAShapeLayer *layerWithHole;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self performSelectorInBackground:@selector(initRecogKernal) withObject:nil];
    [self calculationScale];
    [self initCameraAndLayer];
    
    CGRect scanlineFrame = self.scan_line.frame;
    scanlineFrame.origin.x = 0;
    self.scan_line.frame = scanlineFrame;
    linePoint = self.scan_line.center;
    
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(handleSingleFingerEvent:)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    [self.view addGestureRecognizer:singleFingerOne];
}

- (void)calculationScale
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat longSide = MAX(CGRectGetWidth(screenBounds), CGRectGetHeight(screenBounds));
    CGFloat shortSide = MIN(CGRectGetWidth(screenBounds), CGRectGetHeight(screenBounds));
    
    _widthScale =  1280 /longSide;
    _heightScale =  720 /shortSide;
}

//初始化识别核心
- (void) initRecogKernal
{
    _vinTyper = [[VinTyper alloc] init];
    
}
-(void)moveScanline{
//    [self.scan_line setCenter:linePoint];
//    [UIView animateWithDuration:2.5f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
//        CGPoint center = linePoint;
//        center.y +=  self.maskView.centerView.bounds.size.height;
//        [self.scan_line setCenter:center];
//    } completion:^(BOOL finished) {
////        [self moveScanline];
//    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.scan_line.hidden = NO;
//    [self performSelector:@selector(moveScanline)];
    _isRecognize = YES;
    
    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(moveScanline) userInfo:nil repeats:YES];

    
    AVCaptureDevice*camDevice =[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //注册通知
    [camDevice addObserver:self forKeyPath:@"adjustingFocus" options:NSKeyValueObservingOptionNew context:nil];
    if (_isFocusPixels) {
        [camDevice addObserver:self forKeyPath:@"lensPosition" options:NSKeyValueObservingOptionNew context:nil];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOrient:) name:UIDeviceOrientationDidChangeNotification object:nil];

    int nRet = [_vinTyper initVinTyper:@"44175EA0C39664BC2F15" nsReserve:@""];
    if (nRet != 0) {
        if (_isCameraAuthor == NO) {
            [_captureSession stopRunning];
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            NSArray * appleLanguages = [defaults objectForKey:@"AppleLanguages"];
            NSString * systemLanguage = [appleLanguages objectAtIndex:0];
            if (![systemLanguage isEqualToString:@"zh-Hans"]) {
                NSString *initStr = [NSString stringWithFormat:@"Init Error!Error code:%d",nRet];
                UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"Tips" message:initStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alertV show];
            }else{
                NSString *initStr = [NSString stringWithFormat:@"初始化失败!错误代码:%d",nRet];
                UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:initStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alertV show];
            }
        }
    }


}
- (void)didBecomeActive{
//    [self performSelector:@selector(moveScanline)];
}

- (void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    _isRecognize = NO;
    //关闭定时器
    [_timer invalidate];
    _timer = nil;
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_vinTyper freeVinTyper];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    AVCaptureDevice*camDevice =[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [camDevice removeObserver:self forKeyPath:@"adjustingFocus"];
    if (_isFocusPixels) {
        [camDevice removeObserver:self forKeyPath:@"lensPosition"];
    }
    [_captureSession stopRunning];
}
//从缓冲区获取图像数据进行识别
#pragma mark -
#pragma mark AVCaptureSession delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    AVCaptureConnection *output2VideoConnection = [captureOutput connectionWithMediaType:AVMediaTypeVideo];
    output2VideoConnection.videoOrientation = [self videoOrientationFromCurrentDeviceOrientation];
    
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);

    self.resultImg = nil;
    if(!_isFocusing){
        if (_isRecognize == YES) {
            if(_curPosition==_FocusPixelsPosition){
                //开始识别
                int bSuccess = [_vinTyper recognizeVinTyper:baseAddress Width:(int)width Height:(int)height];
                //识别成功
                if(bSuccess == 0)
                {
                    //震动
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    //显示区域图像
                    [self performSelectorOnMainThread:@selector(showResultAndImage:) withObject:_vinTyper.resultImg waitUntilDone:NO];
                    _isRecognize = NO;
                }
                else if (bSuccess == 4)
                {
                    NSLog(@"识别失败");
                }
                NSLog(@"success : %ld",bSuccess);
            }else{
                _curPosition=_FocusPixelsPosition;
            }
        }
        
    }
    
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
}

//单击手势
- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
    if (sender.numberOfTapsRequired == 1) {
        //单指单击
        _isRecognize = YES;
//        _topView.label.text = @"";
//        _topView.promptLabel1.text = @"";
        self.maskView.promptLabel.text = @"将框置于VIN码前";
        [self.maskView.resultImageView setImage:nil];
        self.scan_line.hidden = NO;
    }
}

//显示结果跟图像
-(void)showResultAndImage:(UIImage *)image
{
    [self.maskView.resultImageView setImage:image];
    self.maskView.resultLabel.text = _vinTyper.nsResult;
    
//    [_topView.resultImg setImage:image];
//    _topView.label.text = _vinTyper.nsResult;
//    _topView.promptLabel.text = @"";
    self.maskView.promptLabel.text = @"点击屏幕继续识别";
    self.scan_line.hidden = YES;
    if (self.resultImg) {
        self.resultImg = nil;
    }
    [self alertWithMessage:_vinTyper.nsResult title:@"识别结果"];
//    [self initScanInfoViewWithInfo:_vinTyper.nsResult];
}
- (AVCaptureVideoOrientation) videoOrientationFromCurrentDeviceOrientation {
    AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationLandscapeRight;
    switch ([[UIApplication sharedApplication] statusBarOrientation]) {
        case UIInterfaceOrientationPortrait: {
            orientation = AVCaptureVideoOrientationPortrait;
        }
            break;
        case UIInterfaceOrientationLandscapeLeft: {
            orientation = AVCaptureVideoOrientationLandscapeLeft;
        }
            break;
        case UIInterfaceOrientationLandscapeRight: {
            orientation = AVCaptureVideoOrientationLandscapeRight;
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown: {
            orientation = AVCaptureVideoOrientationPortraitUpsideDown;
        }
            break;
        default:
            break;
    }
    CGRect scanlineFrame = self.scan_line.frame;
    scanlineFrame.origin.x = 0;
    self.scan_line.frame = scanlineFrame;
    linePoint = self.scan_line.center;
    HDSquare *square = self.maskView.maskFrame;

    // 获取对应比例frame
    if (orientation == AVCaptureVideoOrientationLandscapeLeft || orientation == AVCaptureVideoOrientationLandscapeRight)
    {
        square.left = square.frame.origin.x * _widthScale;
        square.top = square.frame.origin.y * _heightScale;
        square.right = CGRectGetMaxX(square.frame) * _widthScale;
        square.bottom = CGRectGetMaxY(square.frame) * _heightScale;
    }
    else
    {
        square.left = square.frame.origin.x * _heightScale;
        square.top = square.frame.origin.y * _widthScale;
        square.right = CGRectGetMaxX(square.frame) * _heightScale;
        square.bottom = CGRectGetMaxY(square.frame) * _widthScale;
        
    }
    square.scaleBounds = CGRectMake(square.left, square.top, square.right - square.left, square.bottom - square.top);
    
    [self setVinType];
    
    return orientation;
}

- (AVCaptureDevice *)captureDevicePosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == position)
        {
            return device;
        }
    }
    return nil;
}
//初始化相机和检测视图层
- (void) initCameraAndLayer
{
    //判断摄像头是否授权
    _isCameraAuthor = NO;
    AVAuthorizationStatus authorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authorStatus == AVAuthorizationStatusRestricted || authorStatus == AVAuthorizationStatusDenied){
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray * allLanguages = [userDefaults objectForKey:@"AppleLanguages"];
        NSString * preferredLang = [allLanguages objectAtIndex:0];
        if (![preferredLang isEqualToString:@"zh-Hans"]) {
            UIAlertView * alt = [[UIAlertView alloc] initWithTitle:@"Please allow to access your device’s camera in “Settings”-“Privacy”-“Camera”" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alt show];
        }else{
            UIAlertView * alt = [[UIAlertView alloc] initWithTitle:@"未获得授权使用摄像头" message:@"请在 '设置-隐私-相机' 中打开" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alt show];
        }
        _isCameraAuthor = YES;
        return;
    }
    //创建会话层,视频浏览分辨率为1280*720
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession setSessionPreset:AVCaptureSessionPreset1280x720];
    
    //创建、配置输入
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == AVCaptureDevicePositionBack){
            _captureDevice = device;
            _captureInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        }
    }
    [_captureSession addInput:_captureInput];
    
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc]init];
    
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    
    dispatch_queue_t queue;
    queue = dispatch_queue_create("cameraQueue", NULL);
    [captureOutput setSampleBufferDelegate:self queue:queue];
    
    NSString* formatKey = (NSString*)kCVPixelBufferPixelFormatTypeKey;
    NSNumber* value = [NSNumber
                       numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary* videoSettings = [NSDictionary
                                   dictionaryWithObject:value forKey:formatKey];
    [captureOutput setVideoSettings:videoSettings];
    [_captureSession addOutput:captureOutput];
    
    //创建、配置输出
    _captureOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [_captureOutput setOutputSettings:outputSettings];
    [_captureSession addOutput:_captureOutput];
    //
    _capturePreview = [AVCaptureVideoPreviewLayer layerWithSession: _captureSession];
    _capturePreview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _capturePreview.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    [self.view.layer addSublayer:_capturePreview];
    _capturePreview.connection.videoOrientation = [self videoOrientationFromCurrentDeviceOrientation];

    [self.view.layer insertSublayer:_capturePreview below:self.maskView.layer];
    [_captureSession startRunning];
    
    //判断是否相位对焦
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        AVCaptureDeviceFormat *deviceFormat = _captureDevice.activeFormat;
        if (deviceFormat.autoFocusSystem == AVCaptureAutoFocusSystemPhaseDetection){
            _isFocusPixels = YES;
        }
    }
    [self setLayerWithHole];
    [self setVinType];
}
- (void)changeOrient:(NSNotification *)noti
{
    _capturePreview.connection.videoOrientation = [self videoOrientationFromCurrentDeviceOrientation];
    [self.view.layer layoutSublayers];
    [self.maskView setNeedsDisplay];
    [self.view setNeedsDisplay];
    [self setMaskLayerWithLayer:self.layerWithHole];
    _capturePreview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setVinType
{
    NSInteger type = 0;
//    if (orient == UIInterfaceOrientationPortrait)
//    {
//        type = 1;
//    }
    
    [_vinTyper setVinRecognizeType:(int)type];
    HDSquare *square = self.maskView.maskFrame;
    //设置vin码的检测区域
    [_vinTyper setVinRegionWithLeft:square.left Top:square.top Right:square.right Bottom:square.bottom];
//    [_vinTyper setVinRegionWithLeft:225 Top:247 Right:1025 Bottom:472];

}

//监听对焦
-(void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    if([keyPath isEqualToString:@"adjustingFocus"]){
        _isFocusing =[[change objectForKey:NSKeyValueChangeNewKey] isEqualToNumber:[NSNumber numberWithInt:1]];
    }
    if([keyPath isEqualToString:@"lensPosition"]){
        _FocusPixelsPosition =[[change objectForKey:NSKeyValueChangeNewKey] floatValue];
    }
}

//拍照按钮点击事件
- (void)photoBtn{
    if(_isRecognize){
        [self captureimage];
    }
}

//拍照
-(void)captureimage
{
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in _captureOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                connection.videoOrientation = [self videoOrientationFromCurrentDeviceOrientation];

                break;
            }
        }
        if (videoConnection) { break; }
    }
//    AVCaptureConnection *output2VideoConnection = [captureOutput connectionWithMediaType:AVMediaTypeVideo];
    //get UIImage
    [_captureOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:
     ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
         if (imageSampleBuffer != NULL) {
             //停止取景
             //             [_captureSession stopRunning];
             _isRecognize = NO;
             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
             UIImage *tempImage = [[UIImage alloc] initWithData:imageData];
//             fullImage = [self fixOrientation:tempImage];
//             UIImage *fullImage = [UIImage imageWithCGImage:tempImage.CGImage];
             
             UIImageOrientation imageOrientation = [self imageOrientationFromCurrentDeviceOrientation];;
             
             
             UIImage *fullImage = [UIImage imageWithCGImage:tempImage.CGImage scale:1.0 orientation:imageOrientation];
             fullImage = [self fixOrientation:fullImage];
             //裁切vin码图像区域
             CGRect rcVin = self.maskView.maskFrame.scaleBounds;
             CGImageRef imageRef = fullImage.CGImage;
             CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rcVin);
             UIGraphicsBeginImageContext(rcVin.size);
             CGContextRef context = UIGraphicsGetCurrentContext();
             CGContextDrawImage(context, rcVin, subImageRef);
             UIImage *vinImage = [UIImage imageWithCGImage:subImageRef];
             UIGraphicsEndImageContext();
             CGImageRelease(subImageRef);
             
             //保存图像到相册
//             UIImageWriteToSavedPhotosAlbum(vinImage, self, nil, NULL);
             [self.maskView.resultImageView setImage:vinImage];
//             _topView.label.text = @"图像已保存至相册";
//             _topView.promptLabel.text = @"";
//             _topView.promptLabel1.text = @"点击屏幕继续识别";
         }
     }];
}

- (IBAction)takePhotoAction:(id)sender {
    [self photoBtn];
}

//隐藏状态栏
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark

CG_INLINE CGRect
CGRectMakeImage(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat ratio = screenHeight/568.0;
    if (screenHeight==480) { //iphone 4/4s
        rect.origin.y = y * ratio;
        rect.origin.x = (x+30) * ratio;
        rect.size.width = width;
        rect.size.height = height;
    }else{
        rect.origin.x = x * ratio;
        rect.origin.y = y * ratio;
        rect.size.width = width * ratio;
        rect.size.height = height * ratio;
        
    }
    return rect;
}

//旋转image
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


- (UIImageOrientation)imageOrientationFromCurrentDeviceOrientation
{
    switch ([[UIApplication sharedApplication] statusBarOrientation]) {
        case UIInterfaceOrientationPortrait: {
            return UIImageOrientationRight;
        }
        case UIInterfaceOrientationLandscapeLeft: {
            return UIImageOrientationDown;
        }
        case UIInterfaceOrientationLandscapeRight: {
            return UIImageOrientationUp;
        }
        case UIInterfaceOrientationPortraitUpsideDown: {
            return UIImageOrientationLeft;
        }
        default:
            break;
    }
    return UIImageOrientationUp;
}


- (void)setLayerWithHole
{
    //设置检测视图层
    self.layerWithHole = [CAShapeLayer layer];
    
    [self setMaskLayerWithLayer:self.layerWithHole];

    [self.view.layer addSublayer:self.layerWithHole];
    
    [self.view.layer setMasksToBounds:YES];
}

- (void)setMaskLayerWithLayer:(CAShapeLayer *)layerWithHole
{
    CGRect screenRect = self.view.bounds;
    CGFloat offset = 1.0f;
    if ([[UIScreen mainScreen] scale] >= 2) {
        offset = 0.5;
    }
    
    
    
    CGRect centerFrame = self.maskView.centerView.frame;
    CGRect centerRect = CGRectInset(centerFrame, -offset, -offset) ;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(screenRect), CGRectGetMinY(screenRect))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(screenRect), CGRectGetMaxY(screenRect))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(screenRect), CGRectGetMaxY(screenRect))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(screenRect), CGRectGetMinY(screenRect))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(screenRect), CGRectGetMinY(screenRect))];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(centerRect), CGRectGetMinY(centerRect))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(centerRect), CGRectGetMaxY(centerRect))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(centerRect), CGRectGetMaxY(centerRect))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMaxX(centerRect), CGRectGetMinY(centerRect))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(centerRect), CGRectGetMinY(centerRect))];
    [layerWithHole setPath:[bezierPath CGPath]];
    [layerWithHole setFillRule:kCAFillRuleEvenOdd];
    [layerWithHole setFillColor:[[UIColor colorWithWhite:0 alpha:0.35] CGColor]];

}

- (void)alertWithMessage:(NSString *)message title:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:NULL];
        [self changeToOtherAPPWithMessage:message];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    
    [alertController addAction:action];
    [alertController addAction:action1];
    
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)changeToOtherAPPWithMessage:(NSString *)message
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@://vin=%@&_callback=%@://",appDelegate.otherAppScheme,message,appDelegate.otherAppScheme]];
            // 返回应用
    [[UIApplication sharedApplication] openURL:url];
        appDelegate.otherAppScheme = nil;
    return;
}//callsuccess

@end
