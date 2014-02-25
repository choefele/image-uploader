//
//  PhotosViewController.m
//  ImageUploader
//
//  Created by Hoefele, Claus on 25.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import "PhotosViewController.h"

#import "PhotoCollectionViewCell.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotosViewController ()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSArray *assets;

@end

@implementation PhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    [self updateData];
    
    // Register for changes to assets
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(assetsLibraryChanged:) name:ALAssetsLibraryChangedNotification object:nil];
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)assetsLibraryChanged:(NSNotification *)notification
{
    [self updateData];
}

- (void)updateData
{
    NSMutableArray *assets = [NSMutableArray array];
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        group.assetsFilter = [ALAssetsFilter allPhotos];
        
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result != nil) {
                [assets addObject:result];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.assets = [assets copy];
                    [self.collectionView reloadData];
                });
            }
        }];
    } failureBlock:NULL];
}

- (IBAction)addPhotos:(id)sender
{
    NSBundle *bundle = NSBundle.mainBundle;
    
    NSArray *imageNames = @[@"IMG_0305", @"IMG_0310"];
    for (NSString *imageName in imageNames) {
        NSString *imagePath = [bundle pathForResource:imageName ofType:@"JPG"];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        [self.assetsLibrary writeImageToSavedPhotosAlbum:image.CGImage orientation:ALAssetOrientationUp completionBlock:NULL];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"photoCell";
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell updateWithAsset:self.assets[indexPath.row]];
    
    return cell;
}

@end
