//
//  CameraView.h
//  CameraApp
//
//  Created by Yanis on 28.03.2024.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CameraVCDelegate.h"

@interface CameraView : UIView
@property (weak, nonatomic) id<CameraVCDelegate> delegate;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCapturePhotoOutput *photoOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
- (void) setupView;

@end
