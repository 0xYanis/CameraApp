//
//  CameraView.m
//  CameraApp
//
//  Created by Yanis on 28.03.2024.
//

#import "CameraView.h"

@interface CameraView () <AVCapturePhotoCaptureDelegate>

@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIButton *galeryButton;

@end

@implementation CameraView

#pragma mark - UI

- (void)setupView {
    self.captureSession = [[AVCaptureSession alloc] init];
    [self cameraAccess];
    [self addCameraLayer];
    [self addCameraButton];
    [self addGaleryButton];
    [self addBlurViews];
}

- (void)addCameraLayer {
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.backgroundColor = [UIColor redColor].CGColor;
    self.previewLayer.frame = self.bounds;
    [self.layer addSublayer:self.previewLayer];
    [self startRunning];
}

- (void)addCameraButton {
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self configureCameraButton:cameraButton];
    cameraButton.backgroundColor = [UIColor whiteColor];
    [cameraButton addTarget:self action:@selector(makePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cameraButton];
}

- (void)configureCameraButton:(UIButton *)button {
    CGFloat centerX = CGRectGetMidX([[UIScreen mainScreen] bounds]) - 30;
    CGFloat bottomY = CGRectGetMaxY([[UIScreen mainScreen] bounds]) - 100;
    button.frame = CGRectMake(centerX, bottomY, 60, 60);
    button.layer.cornerRadius = 0.5 * button.bounds.size.width;
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor systemGray6Color].CGColor;
    button.layer.borderWidth = 5.0;
}

- (void)addGaleryButton {
    UIButton *galeryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self configureGaleryButton:galeryButton];
    [galeryButton addTarget:self action:@selector(galaryTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:galeryButton];
}

- (void)configureGaleryButton:(UIButton *)button {
    CGRect rect = CGRectMake(self.bounds.size.width - 70, self.bounds.size.height - 100, 50, 50);
    UIImageSymbolConfiguration *conf = [UIImageSymbolConfiguration configurationWithPointSize:30 weight:UIImageSymbolWeightBold];
    UIImage *image = [UIImage systemImageNamed:@"photo" withConfiguration:conf];
    button.tintColor = [UIColor whiteColor];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = rect;
}

- (void)addBlurViews {
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *headerBlurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    headerBlurView.frame = CGRectMake(0, 0, self.bounds.size.width, 100);
    [self insertSubview:headerBlurView atIndex:0];

    UIVisualEffectView *footerBlurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    footerBlurView.frame = CGRectMake(0, self.bounds.size.height - 120, self.bounds.size.width, 120);
    [self insertSubview:footerBlurView atIndex:0];
}

#pragma mark - Logic

- (void)cameraAccess {
    NSError *error = nil;
    self.photoOutput = [[AVCapturePhotoOutput alloc] init];
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {}];
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {}];
    
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if (videoInput) {
        [self.captureSession addInput:videoInput];
    } else {
        NSLog(@"Ошибка инициализации видеовхода %@", error);
    }
}

- (void)startRunning {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.captureSession startRunning];
    });
}

- (void)flashScreen {
    UIView *flashView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    flashView.backgroundColor = [UIColor whiteColor];
    flashView.alpha = 1.0;
    [self addSubview:flashView];

    [UIView animateWithDuration:0.3
                     animations:^{ flashView.alpha = 0.0; }
                     completion:^(BOOL finished){ [flashView removeFromSuperview]; }];
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo
                error:(nullable NSError *)error {
    if (error) {
        NSLog(@"Ошибка захвата фото: %@", error);
        return;
    }
    NSData *imageData = photo.fileDataRepresentation;
    UIImage *capturedImage = [UIImage imageWithData:imageData];
    [self.delegate didTakePhoto:capturedImage];
}

#pragma mark <CameraVCDelegate>

- (void)makePhoto:(UIButton *)sender {
//    AVCapturePhotoSettings *photoSettings = [AVCapturePhotoSettings photoSettings];
//    [self.photoOutput capturePhotoWithSettings:photoSettings delegate:self];
    #if DEBUG
    UIImage *image = [UIImage systemImageNamed:@"photo"];
    [self.delegate didTakePhoto:image];
    #endif
    [self flashScreen];
}

- (void)galaryTapped:(UIButton *)sender {
    [self.delegate didTapGalery];
}

@end
