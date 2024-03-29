//
//  CameraVCDelegate.h
//  CameraApp
//
//  Created by Yanis on 28.03.2024.
//

#import <UIKit/UIKit.h>

@protocol CameraVCDelegate <NSObject>
- (void) didTakePhoto:(UIImage *)photo;
- (void) didTapGalery;
@end
