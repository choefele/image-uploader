//
//  AssetsLibraryController.h
//  ImageUploader
//
//  Created by Claus Höfele on 25.02.14.
//  Copyright (c) 2014 Claus Höfele. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetsLibraryController : NSObject

- (id)initWithCollectionView:(UICollectionView *)collectionView;

- (void)writePhoto:(UIImage *)photo withCompletionBlock:(void (^)())completionBlock;

@property (nonatomic, readonly) NSArray *assets;

@end
