//
//  GaleryViewCell.m
//  CameraApp
//
//  Created by Yanis on 28.03.2024.
//

#import "GaleryViewCell.h"

@implementation GaleryViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
@end
