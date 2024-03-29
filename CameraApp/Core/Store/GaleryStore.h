//
//  GaleryStore.h
//  CameraApp
//
//  Created by Yanis on 28.03.2024.
//

#import <UIKit/UIKit.h>

@interface GaleryStore : NSObject

@property (nonatomic, strong) NSMutableArray<UIImage *> *images;

+ (instancetype)shared; // singleton
- (void)addImage:(UIImage *)image;
- (void)removeImageAtIndex:(NSInteger)index;
- (UIImage *)imageAtIndex:(NSInteger)index;

@end
