//
//  GaleryStore.m
//  CameraApp
//
//  Created by Yanis on 28.03.2024.
//

#import "GaleryStore.h"
#import <UIKit/UIKit.h>

@implementation GaleryStore

+ (instancetype)shared {
    static GaleryStore *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _images = [NSMutableArray array];
    }
    return self;
}

- (void)addImage:(UIImage *)image {
    [self.images addObject:image];
}

- (void)removeImageAtIndex:(NSInteger)index {
    [self.images removeObjectAtIndex:index];
}

- (UIImage *)imageAtIndex:(NSInteger)index {
    return self.images[index];
}

@end
