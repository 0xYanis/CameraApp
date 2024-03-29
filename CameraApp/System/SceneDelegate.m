//
//  SceneDelegate.m
//  CameraApp
//
//  Created by Yanis on 28.03.2024.
//

#import "SceneDelegate.h"
#import "CameraViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    CameraViewController *rootController = [[CameraViewController alloc] init];
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
}

@end
