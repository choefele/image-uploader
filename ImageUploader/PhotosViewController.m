//
//  PhotosViewController.m
//  ImageUploader
//
//  Created by Hoefele, Claus on 25.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import "PhotosViewController.h"

#import "AssetsLibraryController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoEditorViewController.h"

@interface PhotosViewController ()

@property (nonatomic, strong) AssetsLibraryController *assetsLibraryController;

@end

@implementation PhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.assetsLibraryController = [[AssetsLibraryController alloc] initWithCollectionView:self.collectionView];
}

- (IBAction)addPhotos:(id)sender
{
    NSBundle *bundle = NSBundle.mainBundle;
    
    NSArray *imageNames = @[@"IMG_0305", @"IMG_0310"];
    for (NSString *imageName in imageNames) {
        NSString *imagePath = [bundle pathForResource:imageName ofType:@"JPG"];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        [self.assetsLibraryController writePhoto:image withCompletionBlock:NULL];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetsLibraryController.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"photoCell";
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell updateWithAsset:self.assetsLibraryController.assets[indexPath.row]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"photosToPhotoEditor"]) {
        UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
        PhotoEditorViewController *photoEditor = (PhotoEditorViewController *)navigationController.topViewController;
        NSIndexPath *indexPath = self.collectionView.indexPathsForSelectedItems.lastObject;
        ALAsset *asset = self.assetsLibraryController.assets[indexPath.row];
        photoEditor.asset = asset;
    }
}

@end
