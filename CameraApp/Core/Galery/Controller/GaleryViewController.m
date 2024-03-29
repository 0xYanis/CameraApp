//
//  GaleryViewController.m
//  CameraApp
//
//  Created by Yanis on 28.03.2024.
//

#import "GaleryViewController.h"
#import "GaleryViewCell.h"
#import "GaleryStore.h"

@interface GaleryViewController ()

@end

@implementation GaleryViewController

static NSString * const cellId = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView registerClass:[GaleryViewCell class] forCellWithReuseIdentifier:cellId];
    self.navigationItem.title = @"Галерея";
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return GaleryStore.shared.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GaleryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    UIImage *image = [GaleryStore.shared imageAtIndex:indexPath.item];
    cell.imageView = [ [UIImageView alloc] initWithImage:image];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = (collectionView.bounds.size.width - 20) / 3;
    return CGSizeMake(cellWidth, cellWidth);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([selectedCell isKindOfClass:[GaleryViewCell class]]) {
        UIImageView *selectedImageView = [(GaleryViewCell *)selectedCell imageView];
        if (selectedImageView.image) {
            UIViewController *fullscreenVC = [[UIViewController alloc] init];
            fullscreenVC.view.backgroundColor = [UIColor whiteColor];
            UIImageView *fullscreenImageView = [[UIImageView alloc] initWithFrame:fullscreenVC.view.bounds];
            fullscreenImageView.image = selectedImageView.image;
            fullscreenImageView.contentMode = UIViewContentModeScaleAspectFit;
            fullscreenImageView.clipsToBounds = YES;
            
            [fullscreenVC.view addSubview:fullscreenImageView];
            [self presentViewController:fullscreenVC animated:YES completion:nil];
        }
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canEditItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
