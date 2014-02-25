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
@property (nonatomic, strong) NSMutableArray *assets;

@end

@implementation PhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    self.assets = [[NSMutableArray alloc] init];
    [self updateData];
    
    // Register for changes to assets
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(assetsLibraryChanged:) name:ALAssetsLibraryChangedNotification object:nil];
}

- (void)assetsLibraryChanged:(NSNotification *)notification
{
    [self updateData];
}

- (void)updateData
{
    [self.assets removeAllObjects];
    [self.collectionView reloadData];
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        group.assetsFilter = [ALAssetsFilter allPhotos];
        
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result != nil) {
                [self.assets addObject:result];
            } else {
                [self.collectionView reloadData];
            }
        }];
    } failureBlock:NULL];
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
