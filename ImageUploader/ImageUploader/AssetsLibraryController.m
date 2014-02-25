//
//  AssetsLibraryController.m
//  ImageUploader
//
//  Created by Claus Höfele on 25.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import "AssetsLibraryController.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface AssetsLibraryController ()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSArray *assets;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation AssetsLibraryController

- (id)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(assetsLibraryChanged:) name:ALAssetsLibraryChangedNotification object:nil];
        
        self.assetsLibrary = [[ALAssetsLibrary alloc] init];
        self.collectionView = collectionView;
        
        [self updateAssets];
    }
    
    return self;
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)writePhoto:(UIImage *)photo withCompletionBlock:(void (^)())completionBlock
{
    ALAssetOrientation orientation = (ALAssetOrientation)photo.imageOrientation;
    [self.assetsLibrary writeImageToSavedPhotosAlbum:photo.CGImage orientation:orientation completionBlock:^(NSURL *assetURL, NSError *error) {
        if (completionBlock) {
            completionBlock();
        }
    }];
}

- (void)assetsLibraryChanged:(NSNotification *)notification
{
    [self updateAssets];
}

- (void)updateAssets
{
    NSMutableArray *assets = [NSMutableArray array];
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
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

@end
