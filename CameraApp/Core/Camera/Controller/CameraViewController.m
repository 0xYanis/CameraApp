//
//  CameraViewController.m
//  CameraApp
//
//  Created by Yanis on 28.03.2024.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"
#import "CameraVCDelegate.h"
#import "GaleryViewController.h"
#import "GaleryStore.h"

@interface CameraViewController () <CameraVCDelegate>
@end

@implementation CameraViewController : UIViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cameraView = [[CameraView alloc] initWithFrame:self.view.bounds];
    [self.cameraView setupView];
    self.cameraView.delegate = self;
    [self.view addSubview:self.cameraView];
}

#pragma mark - <CameraVCDelegate>

- (void)didTakePhoto:(UIImage *)photo; {
    NSLog(@"Maked photo");
    [GaleryStore.shared addImage:photo];
}

- (void)didTapGalery; {
    NSLog(@"Go to galery");
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    UIViewController *galeryViewController = [[GaleryViewController alloc] initWithCollectionViewLayout:layout];
    [self.navigationController pushViewController:galeryViewController animated:YES];
}

@end
